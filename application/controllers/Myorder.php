<?php

defined('BASEPATH') OR exit('No direct script access allowed');
require FCPATH . 'vendor/autoload.php';

class Myorder extends MY_Controller 
{
    private $id;

    public function __construct()
    {
        parent::__construct();
        
        $is_login = $this->session->userdata('is_login');
        $this->id = $this->session->userdata('id');

        if (!$is_login) {   // Jika ternyata belum ada session
            redirect(base_url());
            return;
        }
    }

    public function index()
    {
        $data['title']      = 'Daftar Order';
        $data['content']    = $this->myorder->where('id_user', $this->id)   // Ambil list orders dari user ini
                                ->orderBy('date', 'DESC')                   // Urutkan dari data terbaru
                                ->get();
        $data['page']       = 'pages/myorder/index';

        $this->view($data);
    }

    /**
     * Untuk melihat detail dari suatu order
     */
    public function detail($invoice)
    {
        $data['order']  = $this->myorder->where('invoice', $invoice)->first();
        
        if (!$data['order']) {
            $this->session->set_flashdata('warning', 'Data tidak ditemukan');
            redirect(base_url('myorder'));
        }

        $this->myorder->table   = 'order_detail';
        $data['order_detail']   = $this->myorder->select([
                'order_detail.id_orders', 'order_detail.id_product', 'order_detail.qty', 'order_detail.subtotal', 'product.title', 'product.image', 'product.price'
            ])
            ->join('product')
            ->where('order_detail.id_orders', $data['order']->id)
            ->get();

        if ($data['order']->status !== 'waiting') {     // Jika status sudah tidak waiting (sudah konfirmasi)
            // Ambil order yang sudah dikonfirmasi dari tabel orders_confirm
            // Informasi ini untuk ditampilkan di footer & menghilangkan tombol mencegah user confirm 2x
            $this->myorder->table   = 'orders_confirm';
            $data['order_confirm']  = $this->myorder->where('id_orders', $data['order']->id)->first();
        }

        $data['page']   = 'pages/myorder/detail';

        $this->view($data);
    }

    /**
     * Untuk melakukan konfirmasi pembayaran
     */
    public function confirm($invoice)
    {
        $data['order']  = $this->myorder->where('invoice', $invoice)->first();
        
        if (!$data['order']) {
            $this->session->set_flashdata('warning', 'Data tidak ditemukan');
            redirect(base_url('myorder'));
        }

        // Validasi apakah order dalam status waiting 
        // Jika tidak, redirect kembali ke myorder
        if ($data['order']->status !== 'waiting') {
            $this->session->set_flashdata('warning', 'Bukti transfer sudah dikirim');
            redirect(base_url("myorder/detail/$invoice"));
        }

        if (!$_POST) {
            $data['input'] = (object) $this->myorder->getDefaultValues();
        } else {
            $data['input'] = (object) $this->input->post(null, true);
        }

        if (!empty($_FILES) && $_FILES['image']['name'] !== '') {   // Jika upload'an tidak kosong
            $imageName  = url_title($invoice, '-', true) . '-' . date('YmdHis');    // Membuat slug
            $upload     = $this->myorder->uploadImage('image', $imageName);         // Mulai upload
            if ($upload) {
                // Jika upload berhasil, pasang nama file yang diupload ke dalam database
                $data['input']->image = $upload['file_name'];
            } else {
                redirect(base_url("myorder/confirm/$invoice"));
            }
        }

        if (!$this->myorder->validate()) {
            $data['title']          = 'Konfirmasi Order';
            $data['form_action']    = base_url("myorder/confirm/$invoice");
            $data['page']           = 'pages/myorder/confirm';

            $this->view($data);
            return;
        }

        $this->myorder->table = 'orders_confirm';
        if ($this->myorder->create($data['input'])) {   // Jika insert berhasil
            // Update status order di tabel orders
            $this->myorder->table = 'orders';
            $this->myorder->where('id', $data['input']->id_orders)->update(['status' => 'paid']);

            $this->session->set_flashdata('success', 'Data berhasil disimpan');
        } else {
            $this->session->set_flashdata('error', 'Oops! Terjadi suatu kesalahan');
        }

        redirect(base_url("myorder/detail/$invoice"));
    }

    public function image_required()
    {
        // Jika file upload kosong, 
        // atau file upload pada field image namanya itu kosong
        if (empty($_FILES) || $_FILES['image']['name'] === '') {
            $this->session->set_flashdata('image_error', 'Bukti transfer tidak boleh kosong');
            return false;   // Return false agar tidak melanjutkan proses
        }
        
        return true;
    }

    public function receipt($invoice) {
        $data['title'] = 'Laporan Pembelian';
        $data['order']  = $this->myorder->where('invoice', $invoice)->first();
        
        if (!$data['order']) {
            $this->session->set_flashdata('warning', 'Data tidak ditemukan');
            redirect(base_url('myorder'));
        }

        $this->myorder->table   = 'order_detail';
        $data['order_detail']   = $this->myorder->select([
                'order_detail.id_orders', 'order_detail.id_product', 'order_detail.qty', 'order_detail.subtotal', 'product.title', 'product.image', 'product.price'
            ])
            ->join('product')
            ->where('order_detail.id_orders', $data['order']->id)
            ->get();

        $data['page']   = 'pages/myorder/receipt';
        
        $html = $this->load->view("pages/myorder/receipt", $data, true);
        $mpdf = new \Mpdf\Mpdf([
            'format' => 'A4',
            'margin_left' => '15',
            'margin_right' => '15',
            'margin_top' => '10',
            'margin_bottom' => '0',
        ]);
        $mpdf->WriteHTML($html);
        $content = $mpdf->Output('', 'S');

        $subject = 'Notifikasi Pembelian';
        $mailTo = $this->session->userdata('email');
        $name = $this->session->userdata('name');

        $this->load->library('email');
        $config = array(
            'protocol' => 'smtp',
            'smtp_host' => 'ssl://smtp.gmail.com',
            'smtp_port' => 465,
            'smtp_user' => 'rifkialfiansyah99@gmail.com',
            'smtp_pass' => 'qrub ajmj wuek rkmr',
            'mailtype' => 'html',
            'newline' => "\r\n"
        );

        $this->email->initialize($config);
        $this->email->set_newline("\r\n");
        $this->email->to($mailTo);
        $this->email->from('sehatkuyfarmasi@gmail.com', 'Sehat Kuy Farmasi');
        $this->email->subject($subject);
        $this->email->message("Hai $name! terima kasih telah menggunakan aplikasi Sehatin. Pembelian anda telah berhasil diproses. Berikut adalah detail pembelian anda.");
        $this->email->attach($content, 'attachment', 'laporan.pdf', 'application/pdf');
        if($this->email->send())
        {
            $this->session->set_flashdata('success', 'Email berhasil dikirim');
        }
        else
        {
            $this->session->set_flashdata('error', 'Email gagal dikirim');
        }
        redirect(base_url("myorder/detail/$invoice"));
    }
}

/* End of file Myorder.php */
