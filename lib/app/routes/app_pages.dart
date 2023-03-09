import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_head_carrier/list_head_carrier_binding.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_head_carrier/list_head_carrier_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_transporter_notif/list_transporter_notif_binding.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_transporter_notif/list_transporter_notif_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_edit_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_edit_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_filter_views/ZO_promo_transporter_filter_location/ZO_promo_transporter_filter_location_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_filter_views/ZO_promo_transporter_filter_location/ZO_promo_transporter_filter_location_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_filter_views/ZO_promo_transporter_filter_transporter/ZO_promo_transporter_filter_transporter_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_filter_views/ZO_promo_transporter_filter_transporter/ZO_promo_transporter_filter_transporter_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_filter_views/ZO_promo_transporter_filter_truck/ZO_promo_transporter_filter_truck_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_filter_views/ZO_promo_transporter_filter_truck/ZO_promo_transporter_filter_truck_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_view.dart';
import 'package:muatmuat/app/modules/data_kapasitas_pengiriman/data_kapasitas_pengiriman_binding.dart';
import 'package:muatmuat/app/modules/data_kapasitas_pengiriman/data_kapasitas_pengiriman_view.dart';
import 'package:muatmuat/app/modules/fake_home/fake_home_binding.dart';
import 'package:muatmuat/app/modules/home/bahasa_placeholder/bahasaPlaceholder_binding.dart';
import 'package:muatmuat/app/modules/home/bahasa_placeholder/bahasaPlaceholder_view.dart';
import 'package:muatmuat/app/modules/ARK/afterLoginSubUser/afterLoginSubUser_binding.dart';
import 'package:muatmuat/app/modules/ARK/afterLoginSubUser/afterLoginSubUser_view.dart';
// import 'package:muatmuat/app/modules/home/home/home_new/afterLoginSubUser_binding.dart';
// import 'package:muatmuat/app/modules/home/home/home_new/afterLoginSubUser_view.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/cari_harga_transport/cari_harga_transport_binding.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/cari_harga_transport/cari_harga_transport_view.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/create_notification_harga/create_notification_harga_binding.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/create_notification_harga/create_notification_harga_view.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/edit_notification_harga/edit_notification_harga_binding.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/edit_notification_harga/edit_notification_harga_view.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/hasil_cari_harga_transport/hasil_cari_harga_transport_binding.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/hasil_cari_harga_transport/hasil_cari_harga_transport_view.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/ketentuan_harga_transport/ketentuan_harga_transport_binding.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/ketentuan_harga_transport/ketentuan_harga_transport_view.dart';
import 'package:muatmuat/app/modules/ARK/demo/lihat_dokumen_persyaratan/lihat_dokumen_persyaratan_binding.dart';
import 'package:muatmuat/app/modules/ARK/demo/lihat_dokumen_persyaratan/lihat_dokumen_persyaratan_view.dart';
import 'package:muatmuat/app/modules/ARK/demo/lihat_video/lihat_video_binding.dart';
import 'package:muatmuat/app/modules/ARK/demo/lihat_video/lihat_video_view.dart';
import 'package:muatmuat/app/modules/ARK/demo/selamat_datang/selamat_datang_binding.dart';
import 'package:muatmuat/app/modules/ARK/demo/selamat_datang/selamat_datang_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/lihat_pdf/lihat_pdf_binding.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/lihat_pdf/lihat_pdf_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_carrier_filter_ark/list_carrier_filter_ark_binding.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_carrier_filter_ark/list_carrier_filter_ark_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_city_filter_ark/list_city_filter_ark_binding.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_city_filter_ark/list_city_filter_ark_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_destinasi_filter_ark/list_destinasi_filter_ark_binding.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_destinasi_filter_ark/list_destinasi_filter_ark_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_diumumkan_kepada_filter/list_diumumkan_kepada_filter_binding.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_diumumkan_kepada_filter/list_diumumkan_kepada_filter_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_diumumkan_kepada_tender/list_diumumkan_kepada_tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_diumumkan_kepada_tender/list_diumumkan_kepada_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_invited_transporter_tender/list_invited_transporter_tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_invited_transporter_tender/list_invited_transporter_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_location_filter_ark/list_location_filter_ark_binding.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_location_filter_ark/list_location_filter_ark_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_muatan_filter/list_muatan_filter_binding.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_muatan_filter/list_muatan_filter_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_province_filter_ark/list_province_filter_ark_binding.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_province_filter_ark/list_province_filter_ark_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_truck_filter_ark/list_truck_filter_ark_binding.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_truck_filter_ark/list_truck_filter_ark_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/search_location_address/search_location_address_binding.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/search_location_address/search_location_address_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_city_location/select_city_location_binding.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_city_location/select_city_location_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_diumumkan_kepada/select_diumumkan_kepada_binding.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_diumumkan_kepada/select_diumumkan_kepada_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_rute_tender/select_rute_tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_rute_tender/select_rute_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_transporter_mitra_tender/select_transporter_mitra_tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_transporter_mitra_tender/select_transporter_mitra_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/browse_info_pra_tender/browse_info_pra_tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/browse_info_pra_tender/browse_info_pra_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/create_info_pra_tender/create_info_pra_tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/create_info_pra_tender/create_info_pra_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/detail_info_pra_tender/detail_info_pra_tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/detail_info_pra_tender/detail_info_pra_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/edit_info_pra_tender/edit_info_pra_tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/edit_info_pra_tender/edit_info_pra_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/info_pra_tender/info_pra_tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/info_pra_tender/info_pra_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/search_info_pra_tender/search_info_pra_tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/search_info_pra_tender/search_info_pra_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/create_manajemen_role/create_manajemen_role_binding.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/create_manajemen_role/create_manajemen_role_view.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/detail_manajemen_role/detail_manajemen_role_binding.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/detail_manajemen_role/detail_manajemen_role_view.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/edit_manajemen_role/edit_manajemen_role_binding.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/edit_manajemen_role/edit_manajemen_role_view.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/manajemen_hak_akses/manajemen_hak_akses_binding.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/manajemen_hak_akses/manajemen_hak_akses_view.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/manajemen_role/manajemen_role_binding.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/manajemen_role/manajemen_role_view.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/search_manajemen_role/search_manajemen_role_binding.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_role/search_manajemen_role/search_manajemen_role_view.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/create_manajemen_user/create_manajemen_user_binding.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/create_manajemen_user/create_manajemen_user_view.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/create_password_subuser/create_password_subuser_binding.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/create_password_subuser/create_password_subuser_view.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/manajemen_user/manajemen_user_binding.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/manajemen_user/manajemen_user_view.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/manajemen_user_bagi_peran/manajemen_user_bagi_peran_binding.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/manajemen_user_bagi_peran/manajemen_user_bagi_peran_view.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/otp_phone_ark/otp_phone_ark_binding.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/otp_phone_ark/otp_phone_ark_view.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/search_bagi_peran_sub_user/search_bagi_peran_sub_user_binding.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/search_bagi_peran_sub_user/search_bagi_peran_sub_user_view.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/search_manajemen_user/search_manajemen_user_binding.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/search_manajemen_user/search_manajemen_user_view.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/success_register_ark/success_register_ark_binding.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/success_register_ark/success_register_ark_view.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta/list_halaman_peserta_binding.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta/list_halaman_peserta_view.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_detail_kebutuhan/list_halaman_peserta_detail_kebutuhan_binding.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_detail_kebutuhan/list_halaman_peserta_detail_kebutuhan_view.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_detail_pemenang/list_halaman_peserta_detail_pemenang_binding.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_detail_pemenang/list_halaman_peserta_detail_pemenang_view.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_detail_penawaran/list_halaman_peserta_detail_penawaran_binding.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_detail_penawaran/list_halaman_peserta_detail_penawaran_view.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_pilih_pemenang/list_halaman_peserta_pilih_pemenang_binding.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_pilih_pemenang/list_halaman_peserta_pilih_pemenang_view.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_pilih_pemenang/list_pilih_pemenang_binding.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_pilih_pemenang/list_pilih_pemenang_view.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_pilih_pemenang_telah_dipilih/list_pilih_pemenang_telah_dipilih_binding.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_pilih_pemenang_telah_dipilih/list_pilih_pemenang_telah_dipilih_view.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_tentukan_pemenang_tender/list_tentukan_pemenang_tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_tentukan_pemenang_tender/list_tentukan_pemenang_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/pemenang_tender/pemenang_tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/pemenang_tender/pemenang_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/search_list_halaman_peserta/search_list_halaman_peserta_binding.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/search_list_halaman_peserta/search_list_halaman_peserta_view.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/search_list_pilih_pemenang/search_list_pilih_pemenang_binding.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/search_list_pilih_pemenang/search_list_pilih_pemenang_view.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/search_pemenang_tender/search_pemenang_tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/search_pemenang_tender/search_pemenang_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/create_proses_tender/create_proses_tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/create_proses_tender/create_proses_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/detail_proses_tender/detail_proses_tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/detail_proses_tender/detail_proses_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/edit_proses_tender/edit_proses_tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/edit_proses_tender/edit_proses_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/informasi_proses_tender/informasi_proses_tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/informasi_proses_tender/informasi_proses_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/proses_tender/proses_tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/proses_tender/proses_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/search_proses_tender/search_proses_tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/search_proses_tender/search_proses_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/tender/tender_binding.dart';
import 'package:muatmuat/app/modules/ARK/tender/tender_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/bigfleet3/instant_order/instant-order-binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/bigfleet3/instant_order/instant-order-view.dart';
import 'package:muatmuat/app/modules/home/home/logistik_new/report/report_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik_new/report/report_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik_new/testimoni/testimoni_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik_new/testimoni/testimoni_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik_new/transport_market/transport_market_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik_new/transport_market/transport_market_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_beri_rating/ZO_beri_rating_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_beri_rating/ZO_beri_rating_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_buat_lelang_muatan/ZO_buat_lelang_muatan_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_buat_lelang_muatan/ZO_buat_lelang_muatan_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_detail_lelang_muatan/ZO_detail_lelang_muatan_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_detail_lelang_muatan/ZO_detail_lelang_muatan_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_filter_jenis_truk_lelang_muatan/ZO_filter_jenis_truk_lelang_muatan_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_filter_jenis_truk_lelang_muatan/ZO_filter_jenis_truk_lelang_muatan_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_filter_truck_satuan/ZO_filter_truck_satuan_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_filter_truck_satuan/ZO_filter_truck_satuan_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_home_transport_market/ZO_home_transport_market_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_home_transport_market/ZO_home_transport_market_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_lelang_muatan/ZO_lelang_muatan_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_lelang_muatan/ZO_lelang_muatan_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_lelang_muatan_filter/ZO_filter_lelang_muatan_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_lelang_muatan_filter/ZO_filter_lelang_muatan_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_list_muatan/ZO_list_muatan_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_list_muatan/ZO_list_muatan_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_list_notifikasi_shipper/ZO_list_notifikasi_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_list_notifikasi_shipper/ZO_list_notifikasi_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_map_full_screen/ZO_map_full_screen_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_map_full_screen/ZO_map_full_screen_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_map_full_screen_tambah/ZO_map_full_screen_tambah_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_map_full_screen_tambah/ZO_map_full_screen_tambah_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_map_select/ZO_map_select_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_map_select/ZO_map_select_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_map_select_location/ZO_map_select_location_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_map_select_location/ZO_map_select_location_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_widgets/ZO_pemenang_lelang_search_page.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_peserta_lelang/ZO_peserta_lelang_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_peserta_lelang/ZO_peserta_lelang_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_peserta_lelang_search/ZO_peserta_lelang_search_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_peserta_lelang_search/ZO_peserta_lelang_search_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pilih_pemenang_lelang/ZO_pilih_pemenang_lelang_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pilih_pemenang_lelang/ZO_pilih_pemenang_lelang_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pilih_pemenang_search/ZO_pilih_pemenang_search_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pilih_pemenang_search/ZO_pilih_pemenang_search_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_search_lokasi/ZO_search_lokasi_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_search_lokasi/ZO_search_lokasi_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/Zo_search_lelang_muatan_list/Zo_search_lelang_muatan_list_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/Zo_search_lelang_muatan_list/Zo_search_lelang_muatan_list_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Manajement%20Promo/ZO_buat_harga_promo/ZO_buat_harga_promo_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Manajement%20Promo/ZO_buat_harga_promo/ZO_buat_harga_promo_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Manajement%20Promo/ZO_list_harga_promo/ZO_list_harga_promo_binding.dart';
import 'package:muatmuat/app/modules/Zero%20One/Manajement%20Promo/ZO_list_harga_promo/ZO_list_harga_promo_view.dart';
import 'package:muatmuat/app/modules/article/article_binding.dart';
import 'package:muatmuat/app/modules/article/article_view.dart';
import 'package:muatmuat/app/modules/balance/balance_binding.dart';
import 'package:muatmuat/app/modules/balance/balance_view.dart';
import 'package:muatmuat/app/modules/bigfleets/bigfleets_binding.dart';
import 'package:muatmuat/app/modules/bigfleets/bigfleets_view.dart';
import 'package:muatmuat/app/modules/choose_area_pickup_internal/choose_area_pickup_internal_binding.dart';
import 'package:muatmuat/app/modules/choose_area_pickup_internal/choose_area_pickup_internal_view.dart';
import 'package:muatmuat/app/modules/choose_business_field/choose_business_field_binding.dart';
import 'package:muatmuat/app/modules/choose_business_field/choose_business_field_view.dart';
import 'package:muatmuat/app/modules/choose_district/choose_district_binding.dart';
import 'package:muatmuat/app/modules/choose_district/choose_district_view.dart';
import 'package:muatmuat/app/modules/create_password/create_password_binding.dart';
import 'package:muatmuat/app/modules/create_password/create_password_view.dart';
import 'package:muatmuat/app/modules/fake_home/fake_home.dart';
import 'package:muatmuat/app/modules/file_example/file_example_binding.dart';
import 'package:muatmuat/app/modules/file_example/file_example_view.dart';
import 'package:muatmuat/app/modules/forgot_password/forgot_password_binding.dart';
import 'package:muatmuat/app/modules/forgot_password/forgot_password_view.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_notifikasi/manajemen_notifikasi_aplikasi/manajemen_notifikasi_aplikasi_binding.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_notifikasi/manajemen_notifikasi_aplikasi/manajemen_notifikasi_aplikasi_view.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_notifikasi/ringkasan_manajemen_notifikasi/ringkasan_manajemen_notifikasi_binding.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_notifikasi/ringkasan_manajemen_notifikasi/ringkasan_manajemen_notifikasi_view.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/data_armada/data_armada_binding.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/data_armada/data_armada_view.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/foto_dan_video/foto_video_bindings.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/foto_dan_video/foto_video_view.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/kontak_pic/kontak_pic_binding.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/kontak_pic/kontak_pic_view.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/tentang_perusahaan/tentang_perusahaan_binding.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/tentang_perusahaan/tentang_perusahaan_view.dart';
import 'package:muatmuat/app/modules/other_side_transporter/profile_perusahaan_binding.dart';
import 'package:muatmuat/app/modules/other_side_transporter/profile_perusahaan_view.dart';
import 'package:muatmuat/app/modules/home/before_login/beforeLoginUser_binding.dart';
import 'package:muatmuat/app/modules/home/before_login/beforeLoginUser_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/bigfleet/bigfleets2_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/bigfleet/bigfleets2_view.dart';
import 'package:muatmuat/app/modules/carousel_gallery/carousel_gallery_binding.dart';
import 'package:muatmuat/app/modules/carousel_gallery/carousel_gallery_view.dart';
import 'package:muatmuat/app/modules/choose_area_pickup/choose_area_pickup_binding.dart';
import 'package:muatmuat/app/modules/choose_area_pickup/choose_area_pickup_view.dart';
import 'package:muatmuat/app/modules/choose_ekspetasi_destinasi/choose_ekspetasi_destinasi_binding.dart';
import 'package:muatmuat/app/modules/choose_ekspetasi_destinasi/choose_ekspetasi_destinasi_view.dart';
import 'package:muatmuat/app/modules/choose_user_type/choose_user_type_binding.dart';
import 'package:muatmuat/app/modules/choose_user_type/choose_user_type_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/detail_permintaan_muat/component/map_detail_permintaan_muat.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/create_group_tambah_anggota/create_group_tambah_anggota_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/create_group_tambah_anggota/create_group_tambah_anggota_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/detail_tambah_anggota/detail_manajemen_group_tambah_anggota_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/detail_tambah_anggota/detail_manajemen_group_tambah_anggota_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/search_detail_manajemen_group_mitra/search_detail_manajemen_group_mitra_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/search_detail_manajemen_group_mitra/search_detail_manajemen_group_mitra_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/choose_subuser/tm_choose_subuser_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/choose_subuser/tm_choose_subuser_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/choose_voucher/tm_choose_voucher_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/choose_voucher/tm_choose_voucher_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/create_subscription/tm_create_subscription_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/create_subscription/tm_create_subscription_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/create_subuser/tm_create_subuser_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/create_subuser/tm_create_subuser_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/kartu_kredit_debiit_online/tm_kartu_kredit_debit_online_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/kartu_kredit_debiit_online/tm_kartu_kredit_debit_online_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list/tm_subscription_menunggu_pembayaran_list_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list/tm_subscription_menunggu_pembayaran_list_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list_search/tm_subscription_menunggu_pembayaran_list_search_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list_search/tm_subscription_menunggu_pembayaran_list_search_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list_search_result/tm_subscription_menunggu_pembayaran_list_search_result_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list_search_result/tm_subscription_menunggu_pembayaran_list_search_result_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/pembayaran_subscription/tm_pembayaran_subscription_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/pembayaran_subscription/tm_pembayaran_subscription_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/pilih_metode_pembayaran/tm_subscription_pilih_metode_pembayaran_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/pilih_metode_pembayaran/tm_subscription_pilih_metode_pembayaran_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_bf_dan_su_list/tm_riwayat_langganan_bf_dan_su_list_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_bf_dan_su_list/tm_riwayat_langganan_bf_dan_su_list_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_bf_list_search/tm_riwayat_langganan_bf_search_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_bf_list_search/tm_riwayat_langganan_bf_search_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_bf_list_search_result/tm_riwayat_langganan_bf_result_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_bf_list_search_result/tm_riwayat_langganan_bf_result_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_su_list_search/tm_riwayat_langganan_su_search_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_su_list_search/tm_riwayat_langganan_su_search_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_su_list_search_result/tm_riwayat_langganan_su_result_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_su_list_search_result/tm_riwayat_langganan_su_result_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list/tm_subscription_riwayat_pesanan_list_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list/tm_subscription_riwayat_pesanan_list_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list_search/tm_subscription_riwayat_pesanan_list_search_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list_search/tm_subscription_riwayat_pesanan_list_search_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list_search_result/tm_subscription_riwayat_pesanan_list_search_result_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list_search_result/tm_subscription_riwayat_pesanan_list_search_result_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/subscription_detail/tm_subscription_detail_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/subscription_detail/tm_subscription_detail_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/subscription_home/tm_subscription_home_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/subscription_home/tm_subscription_home_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/terms_and_conditions_subscription/tm_terms_and_conditions_subscription_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/terms_and_conditions_subscription/tm_terms_and_conditions_subscription_view.dart';
// import 'package:muatmuat/app/modules/home/home/logistik/transport_market/transport_market/transport_market_binding.dart';
// import 'package:muatmuat/app/modules/home/home/logistik/transport_market/transport_market/transport_market_view.dart';
import 'package:muatmuat/app/modules/home/profile/component/ubah_foto_profil/ubah_foto_profil_binding.dart';
import 'package:muatmuat/app/modules/home/profile/component/ubah_foto_profil/ubah_foto_profil_view.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/form_email_profile/form_email_profile_binding.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/form_email_profile/form_email_profile_view.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/form_input_password_profile/form_input_password_profile_binding.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/form_input_password_profile/form_input_password_profile_view.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/form_password_profile/form_password_profile_binding.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/form_password_profile/form_password_profile_view.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/form_phone_profile/form_phone_profile_binding.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/form_phone_profile/form_phone_profile_view.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/otp_email_profile/otp_email_profile_binding.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/otp_email_profile/otp_email_profile_view.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/otp_phone_profile/otp_phone_profile_binding.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/otp_phone_profile/otp_phone_profile_view.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/otp_profile/otp_profile_binding.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/otp_profile/otp_profile_view.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/pengaturan_akun/pengaturan_akun_binding.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/pengaturan_akun/pengaturan_akun_view.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/syarat_dan_kebijakan/syarat_dan_kebijakan_binding.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/syarat_dan_kebijakan/syarat_dan_kebijakan_view.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/zona_waktu_dan%20bahasa/zona_waktu_dan%20bahasa_binding.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/zona_waktu_dan%20bahasa/zona_waktu_dan%20bahasa_view.dart';
import 'package:muatmuat/app/modules/home/profile/profil_binding.dart';
import 'package:muatmuat/app/modules/home/profile/profil_view.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/detail_manajemen_lokasi/detail_manajemen_lokasi_binding.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/detail_manajemen_lokasi/detail_manajemen_lokasi_view.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/list_management_lokasi/list_management_lokasi_binding.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/list_management_lokasi/list_management_lokasi_view.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/map_management_lokasi/map_management_lokasi_binding.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/map_management_lokasi/map_management_lokasi_view.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/search_list_management_lokasi/search_list_management_lokasi_binding.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/search_list_management_lokasi/search_list_management_lokasi_view.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/search_location_add_edit_manajemen_lokasi/search_location_add_edit_manajemen_lokasi_view.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/search_location_add_edit_manajemen_lokasi/search_location_add_edit_manajemen_lokasibinding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/pilih_metode_pembayaran/subscription_pilih_metode_pembayaran_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/pilih_metode_pembayaran/subscription_pilih_metode_pembayaran_view.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_notifikasi/manajemen_notifikasi_binding.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_notifikasi/manajemen_notifikasi_email/manajemen_notifikasi_email_binding.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_notifikasi/manajemen_notifikasi_email/manajemen_notifikasi_email_view.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_notifikasi/manajemen_notifikasi_view.dart';
import 'package:muatmuat/app/modules/intro_shipper/intro_binding.dart';
import 'package:muatmuat/app/modules/intro_shipper/intro_view.dart';
import 'package:muatmuat/app/modules/login/login_binding.dart';
import 'package:muatmuat/app/modules/login/login_view.dart';
import 'package:muatmuat/app/modules/lokasi_bf_tm/lokasi_bf_tm_binding.dart';
import 'package:muatmuat/app/modules/lokasi_bf_tm/lokasi_bf_tm_view.dart';
import 'package:muatmuat/app/modules/otp_email_bftm/otp_email_binding_bftm.dart';
import 'package:muatmuat/app/modules/otp_email_bftm/otp_email_view_bftm.dart';
import 'package:muatmuat/app/modules/otp_forget_password/otp_forget_password_binding.dart';
import 'package:muatmuat/app/modules/otp_forget_password/otp_forget_password_view.dart';
import 'package:muatmuat/app/modules/otp_phone/otp_phone_binding.dart';
import 'package:muatmuat/app/modules/otp_phone/otp_phone_view.dart';
import 'package:muatmuat/app/modules/privacy_and_policy_register/privacy_policy_register_binding.dart';
import 'package:muatmuat/app/modules/privacy_and_policy_register/privacy_policy_register_view.dart';
import 'package:muatmuat/app/modules/profile_individu/components/search_kecamatan/search_kecamatan_binding.dart';
import 'package:muatmuat/app/modules/profile_individu/components/search_kecamatan/search_kecamatan_view.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_pribadi/component/lokasi_data_individu_pribadi/lokasi_ubah_data_individu_binding.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_pribadi/component/lokasi_data_individu_pribadi/lokasi_ubah_data_individu_view.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_pribadi/component/search_location_map_marker_data_pribadi/search_location_map_marker_data_usaha_binding.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_pribadi/component/search_location_map_marker_data_pribadi/search_location_map_marker_data_usaha_view.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_pribadi/component/search_lokasi_data_pribadi/search_lokasi_data_pribadi_binding.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_pribadi/component/search_lokasi_data_pribadi/search_lokasi_data_pribadi_view.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_pribadi/ubah_data_pribadi_binding.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_pribadi/ubah_data_pribadi_view.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_usaha/component/lokasi_data_individu_usaha/lokasi_data_individu_usaha_binding.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_usaha/component/lokasi_data_individu_usaha/lokasi_data_individu_usaha_view.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_usaha/component/search_location_map_marker_data_usaha/search_location_map_marker_data_usaha_binding.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_usaha/component/search_location_map_marker_data_usaha/search_location_map_marker_data_usaha_view.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_usaha/component/search_lokasi_data_usaha/search_lokasi_data_usaha_binding.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_usaha/component/search_lokasi_data_usaha/search_lokasi_data_usaha_view.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_usaha/ubah_data_usaha_binding.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_usaha/ubah_data_usaha_view.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_logo_individu/ubah_foto_individu_view.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_logo_individu/ubah_logo_individu_binding.dart';
import 'package:muatmuat/app/modules/profile_individu/profile_individu_binding.dart';
import 'package:muatmuat/app/modules/profile_individu/profile_individu_view.dart';
import 'package:muatmuat/app/modules/profile_perusahaan/components/ubah_logo_perusahaan/ubah_foto_perusahaan_view.dart';
import 'package:muatmuat/app/modules/profile_perusahaan/components/ubah_logo_perusahaan/ubah_logo_perusahaan_binding.dart';
import 'package:muatmuat/app/modules/profile_perusahaan/modules/peta_lokasi_profile_perusahaan/peta_lokasi_profile_perusahaan_view.dart';
import 'package:muatmuat/app/modules/register_shipper_bf_tm/register_shipper_bf_tm_binding.dart';
import 'package:muatmuat/app/modules/register_shipper_bf_tm/register_shipper_bf_tm_view.dart';
import 'package:muatmuat/app/modules/register_user/register_binding.dart';
import 'package:muatmuat/app/modules/register_user/register_view.dart';
import 'package:muatmuat/app/modules/register_google/register_google_view.dart';
import 'package:muatmuat/app/modules/search_location_bf_tm/search_location_bf_tm_binding.dart';
import 'package:muatmuat/app/modules/search_location_bf_tm/search_location_bf_tm_view.dart';
import 'package:muatmuat/app/modules/search_location_lokasi_truk_siap_muat/search_location_lokasi_truk_siap_muat_binding.dart';
import 'package:muatmuat/app/modules/search_location_lokasi_truk_siap_muat/search_location_lokasi_truk_siap_muat_view.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/search_result_list_management_lokasi/search_result_list_management_lokasi_binding.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/search_result_list_management_lokasi/search_result_list_management_lokasi_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/choose_subuser/choose_subuser_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/choose_subuser/choose_subuser_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/choose_voucher/choose_voucher_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/choose_voucher/choose_voucher_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/create_subscription/create_subscription_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/create_subscription/create_subscription_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/create_subuser/create_subuser_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/create_subuser/create_subuser_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/kartu_kredit_debiit_online/kartu_kredit_debit_online_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/kartu_kredit_debiit_online/kartu_kredit_debit_online_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list/subscription_menunggu_pembayaran_list_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list/subscription_menunggu_pembayaran_list_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list_search/subscription_menunggu_pembayaran_list_search_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list_search/subscription_menunggu_pembayaran_list_search_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list_search_result/subscription_menunggu_pembayaran_list_search_result_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list_search_result/subscription_menunggu_pembayaran_list_search_result_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list/subscription_riwayat_pesanan_list_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list/subscription_riwayat_pesanan_list_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/pembayaran_subscription/pembayaran_subscription_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/pembayaran_subscription/pembayaran_subscription_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_bf_dan_su_list/subscription_riwayat_langganan_bf_dan_su_list_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_bf_dan_su_list/subscription_riwayat_langganan_bf_dan_su_list_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_bf_list_search/subscription_riwayat_langganan_bf_list_search_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_bf_list_search/subscription_riwayat_langganan_bf_list_search_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_bf_list_search_result/subscription_riwayat_langganan_bf_list_search_result_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_bf_list_search_result/subscription_riwayat_langganan_bf_list_search_result_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_su_list_search/subscription_riwayat_langganan_su_list_search_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_su_list_search/subscription_riwayat_langganan_su_list_search_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_su_list_search_result/subscription_riwayat_langganan_su_list_search_result_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_su_list_search_result/subscription_riwayat_langganan_su_list_search_result_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list_search/subscription_riwayat_pesanan_list_search_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list_search/subscription_riwayat_pesanan_list_search_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list_search_result/subscription_riwayat_pesanan_list_search_result_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list_search_result/subscription_riwayat_pesanan_list_search_result_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/subscription_detail/subscription_detail_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/subscription_detail/subscription_detail_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/subscription_home/subscription_home_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/subscription_home/subscription_home_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/terms_and_conditions_subscription/terms_and_conditions_subscription_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/terms_and_conditions_subscription/terms_and_conditions_subscription_view.dart';
import 'package:muatmuat/app/modules/shipment_capacity_validation/shipment_capacity_validation_binding.dart';
import 'package:muatmuat/app/modules/shipment_capacity_validation/shipment_capacity_validation_view.dart';
import 'package:muatmuat/app/modules/success_create_password/success_create_password_binding.dart';
import 'package:muatmuat/app/modules/success_create_password/success_create_password_view.dart';
import 'package:muatmuat/app/modules/success_register/success_register_binding.dart';
import 'package:muatmuat/app/modules/success_register/success_register_view.dart';
import 'package:muatmuat/app/modules/success_register_bftm/success_register_bftm_view.dart';
import 'package:muatmuat/app/modules/terms_and_conditions_bftm/terms_and_conditions_bftm.dart';
import 'package:muatmuat/app/modules/terms_and_conditions_bftm/terms_and_conditions_bftm_binding.dart';
import 'package:muatmuat/app/modules/terms_and_conditions_register/terms_and_conditions_register.dart';
import 'package:muatmuat/app/modules/terms_and_conditions_register/terms_and_conditions_register_binding.dart';
import 'package:muatmuat/app/modules/testimoni_profile/testimoni_profile_binding.dart';
import 'package:muatmuat/app/modules/testimoni_profile/testimoni_profile_view.dart';
import 'package:muatmuat/app/modules/ubah_data_perusahaan/component/choose_district/choose_district_profil_binding.dart';
import 'package:muatmuat/app/modules/ubah_data_perusahaan/component/choose_district/choose_district_profil_view.dart';
import 'package:muatmuat/app/modules/ubah_data_perusahaan/component/lokasi_data_perusahaan/lokasi_ubah_data_binding.dart';
import 'package:muatmuat/app/modules/ubah_data_perusahaan/component/lokasi_data_perusahaan/lokasi_ubah_data_view.dart';
import 'package:muatmuat/app/modules/ubah_data_perusahaan/component/search_location_map/search_location_map_binding.dart';
import 'package:muatmuat/app/modules/ubah_data_perusahaan/component/search_location_map/search_location_map_view.dart';
import 'package:muatmuat/app/modules/ubah_data_perusahaan/component/search_location_ubah_data/search_location_ubah_data_binding.dart';
import 'package:muatmuat/app/modules/ubah_data_perusahaan/component/search_location_ubah_data/search_location_ubah_data_view.dart';
import 'package:muatmuat/app/modules/ubah_data_perusahaan/ubah_data_perusahaan_bindings.dart';
import 'package:muatmuat/app/modules/ubah_kelengkapan_legalitas/ubah_kelengkapan_legalitas_binding.dart';
import 'package:muatmuat/app/modules/ubah_kelengkapan_legalitas/ubah_kelengkapan_legalitas_view.dart';
import 'package:muatmuat/app/modules/ubah_kelengkapan_legalitas_individu/ubah_kelengkapan_legalitas_individu_binding.dart';
import 'package:muatmuat/app/modules/ubah_kelengkapan_legalitas_individu/ubah_kelengkapan_legalitas_individu_view.dart';
import 'package:muatmuat/app/modules/ubah_kontak_pic/ubah_kontak_pic_bindings.dart';
import 'package:muatmuat/app/modules/ubah_kontak_pic/ubah_kontak_pic_view.dart';
import 'package:muatmuat/app/modules/ubah_testimoni_profile/ubah_testimoni_profile_binding.dart';
import 'package:muatmuat/app/modules/ubah_testimoni_profile/ubah_testimoni_profile_view.dart';
import 'package:muatmuat/app/modules/upload_legalitas/upload_legalitas_binding.dart';
import 'package:muatmuat/app/modules/upload_legalitas/upload_legalitas_view.dart';
import 'package:muatmuat/app/modules/upload_picture/upload_picture_binding.dart';
import 'package:muatmuat/app/modules/upload_picture/upload_picture_view.dart';
import 'package:muatmuat/app/modules/user_type_information/user_type_information_binding.dart';
import 'package:muatmuat/app/modules/user_type_information/user_type_information_view.dart';
import 'package:muatmuat/app/modules/contact_support/support_binding.dart';
import 'package:muatmuat/app/modules/contact_support/support_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/create_group/create_group_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/create_group/create_group_view.dart';
import 'package:muatmuat/app/modules/create_order_entry/create_order_entry_binding.dart';
import 'package:muatmuat/app/modules/create_order_entry/create_order_entry_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/create_permintaan_muat/create_permintaan_muat_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/create_permintaan_muat/create_permintaan_muat_view.dart';
import 'package:muatmuat/app/modules/create_pratender/create_pratender_binding.dart';
import 'package:muatmuat/app/modules/create_pratender/create_pratender_view.dart';
import 'package:muatmuat/app/modules/detail_ltsm/detail_ltsm_binding.dart';
import 'package:muatmuat/app/modules/detail_ltsm/detail_ltsm_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/detail_manajemen_group_mitra/detail_manajemen_group_mitra_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/detail_manajemen_group_mitra/detail_manajemen_group_mitra_view.dart';
import 'package:muatmuat/app/modules/detail_manajemen_order/detail_manajemen_order_binding.dart';
import 'package:muatmuat/app/modules/detail_manajemen_order/detail_manajemen_order_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/detail_permintaan_muat/detail_permintaan_muat_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/detail_permintaan_muat/detail_permintaan_muat_view.dart';
import 'package:muatmuat/app/modules/detail_pratender/detail_pratender_binding.dart';
import 'package:muatmuat/app/modules/detail_pratender/detail_pratender_view.dart';
import 'package:muatmuat/app/modules/detail_profil_shipper/detail_profil_shipper_binding.dart';
import 'package:muatmuat/app/modules/detail_profil_shipper/detail_profil_shipper_view.dart';
import 'package:muatmuat/app/modules/detail_profil_shipper_company/detail_profil_shipper_company_binding.dart';
import 'package:muatmuat/app/modules/detail_profil_shipper_company/detail_profil_shipper_company_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/edit_group/edit_group_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/edit_group/edit_group_view.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/edit_manajemen_lokasi_info_permintaan_muat/edit_manajemen_lokasi_info_permintaan_muat_binding.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/edit_manajemen_lokasi_info_permintaan_muat/edit_manajemen_lokasi_info_permintaan_muat_view.dart';
import 'package:muatmuat/app/modules/error_register_email_still_verify/error_register_email_still_verify_binding.dart';
import 'package:muatmuat/app/modules/error_register_email_still_verify/error_register_email_still_verify_view.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/filter_manajemen_lokasi/filter_manajemen_lokasi_binding.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/filter_manajemen_lokasi/filter_manajemen_lokasi_view.dart';
import 'package:muatmuat/app/modules/find_truck/find_truck_binding.dart';
import 'package:muatmuat/app/modules/find_truck/find_truck_view.dart';
import 'package:muatmuat/app/modules/from_dest_search_location/from_dest_search_location_binding.dart';
import 'package:muatmuat/app/modules/from_dest_search_location/from_dest_search_location_view.dart';
import 'package:muatmuat/app/modules/group_mitra/group_mitra_binding.dart';
import 'package:muatmuat/app/modules/group_mitra/group_mitra_view.dart';
import 'package:muatmuat/app/modules/home/home/home/home_binding.dart';
import 'package:muatmuat/app/modules/home/home/home/home_view.dart';
import 'package:muatmuat/app/modules/list_area_pickup_search_filter/list_area_pickup_search_filter_binding.dart';
import 'package:muatmuat/app/modules/list_area_pickup_search_filter/list_area_pickup_search_filter_view.dart';
import 'package:muatmuat/app/modules/list_area_pickup_transporter_filter/list_area_pickup_transporter_filter_binding.dart';
import 'package:muatmuat/app/modules/list_area_pickup_transporter_filter/list_area_pickup_transporter_filter_view.dart';
import 'package:muatmuat/app/modules/list_city_filter/list_city_filter_binding.dart';
import 'package:muatmuat/app/modules/list_city_filter/list_city_filter_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/list_info_permintaan_muat/list_info_permintaan_muat_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/list_info_permintaan_muat/list_info_permintaan_muat_view.dart';
import 'package:muatmuat/app/modules/list_search_truck_siap_muat/list_search_truck_siap_muat_binding.dart';
import 'package:muatmuat/app/modules/list_search_truck_siap_muat/list_search_truck_siap_muat_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/list_transporter/list_transporter_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/list_transporter/list_transporter_view.dart';
import 'package:muatmuat/app/modules/list_truck_carrier_filter/list_truck_carrier_filter_binding.dart';
import 'package:muatmuat/app/modules/list_truck_carrier_filter/list_truck_carrier_filter_view.dart';
import 'package:muatmuat/app/modules/list_user/list_user_binding.dart';
import 'package:muatmuat/app/modules/list_user/list_user_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/list_user_info_permintaan_muat/list_user_info_permintaan_muat_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/list_user_info_permintaan_muat/list_user_info_permintaan_muat_view.dart';
import 'package:muatmuat/app/modules/location_truck_ready/location_truck_ready_binding.dart';
import 'package:muatmuat/app/modules/location_truck_ready/location_truck_ready_view.dart';
import 'package:muatmuat/app/modules/location_truck_ready_search/location_truck_ready_search_binding.dart';
import 'package:muatmuat/app/modules/location_truck_ready_search/location_truck_ready_search_view.dart';
import 'package:muatmuat/app/modules/lokasi_truk_siap_muat/lokasi_truk_siap_muat_binding.dart';
import 'package:muatmuat/app/modules/lokasi_truk_siap_muat/lokasi_truk_siap_muat_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/manajemen_mitra/manajemen_mitra_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/manajemen_mitra/manajemen_mitra_view.dart';
import 'package:muatmuat/app/modules/manajemen_order_entry/manajemen_order_binding.dart';
import 'package:muatmuat/app/modules/manajemen_order_entry/manajemen_order_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/map_detail_transporter/map_detail_transporter_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/map_detail_transporter/map_detail_transporter_view.dart';
import 'package:muatmuat/app/modules/notification/notif_binding.dart';
import 'package:muatmuat/app/modules/notification/notif_view.dart';
import 'package:muatmuat/app/modules/pay/pay_binding.dart';
import 'package:muatmuat/app/modules/pay/pay_view.dart';
import 'package:muatmuat/app/modules/peserta_pratender/peserta_pratender_binding.dart';
import 'package:muatmuat/app/modules/peserta_pratender/peserta_pratender_view.dart';
import 'package:muatmuat/app/modules/place_favorite/place_favorite_binding.dart';
import 'package:muatmuat/app/modules/place_favorite/place_favorite_view.dart';
import 'package:muatmuat/app/modules/place_favorite_crud/place_favorite_crud_binding.dart';
import 'package:muatmuat/app/modules/place_favorite_crud/place_favorite_crud_view.dart';
import 'package:muatmuat/app/modules/pratender/pratender_binding.dart';
import 'package:muatmuat/app/modules/pratender/pratender_view.dart';
import 'package:muatmuat/app/modules/privacy_and_policy/privacy_and_policy_binding.dart';
import 'package:muatmuat/app/modules/privacy_and_policy/privacy_and_policy_view.dart';
import 'package:muatmuat/app/modules/home/setting/setting/profile_shipper_binding.dart';
import 'package:muatmuat/app/modules/home/setting/setting/profile_shipper_view.dart';
import 'package:muatmuat/app/modules/register_user/register_user_old/register_user_binding.dart';
import 'package:muatmuat/app/modules/reset_password/reset_password_binding.dart';
import 'package:muatmuat/app/modules/reset_password/reset_password_view.dart';
import 'package:muatmuat/app/modules/reset_password_success/reset_password_success_binding.dart';
import 'package:muatmuat/app/modules/reset_password_success/reset_password_success_view.dart';
import 'package:muatmuat/app/modules/search_city/search_city_binding.dart';
import 'package:muatmuat/app/modules/search_city/search_city_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/search_info_permintaan_muat/search_info_permintaan_muat_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/search_info_permintaan_muat/search_info_permintaan_muat_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/search_list_transporter/search_list_transporter_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/search_list_transporter/search_list_transporter_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/search_location_info_permintaan_muat/search_location_info_permintaan_muat_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/search_location_info_permintaan_muat/search_location_info_permintaan_muat_view.dart';
import 'package:muatmuat/app/modules/search_location_map_marker/search_location_map_marker_binding.dart';
import 'package:muatmuat/app/modules/search_location_map_marker/search_location_map_marker_view.dart';
import 'package:muatmuat/app/modules/search_manajemen_lokasi_info_permintaan_muat/search_manajemen_lokasi_info_permintaan_muat_binding.dart';
import 'package:muatmuat/app/modules/search_manajemen_lokasi_info_permintaan_muat/search_manajemen_lokasi_info_permintaan_muat_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/search_manajemen_mitra/search_manajemen_mitra_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/search_manajemen_mitra/search_manajemen_mitra_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/search_result_info_permintaan_muat/search_result_info_permintaan_muat_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/search_result_info_permintaan_muat/search_result_info_permintaan_muat_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/search_result_list_transporter/search_result_list_transporter_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/search_result_list_transporter/search_result_list_transporter_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/search_result_manajemen_mitra/search_result_manajemen_mitra_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/search_result_manajemen_mitra/search_result_manajemen_mitra_view.dart';
import 'package:muatmuat/app/modules/select_head_carrier/select_head_carrier_binding.dart';
import 'package:muatmuat/app/modules/select_head_carrier/select_head_carrier_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_head_carrier/select_head_carrier_binding.dart'
    as arkshcb;
import 'package:muatmuat/app/modules/ARK/extra_widget/select_head_carrier/select_head_carrier_view.dart'
    as arkshcv;
import 'package:muatmuat/app/modules/select_list_lokasi/select_list_lokasi_binding.dart';
import 'package:muatmuat/app/modules/select_list_lokasi/select_list_lokasi_view.dart';
import 'package:muatmuat/app/modules/setting/setting_binding.dart';
import 'package:muatmuat/app/modules/setting/setting_view.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_binding.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_view.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register_success/shipper_buyer_register_success_binding.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register_success/shipper_buyer_register_success_view.dart';
import 'package:muatmuat/app/modules/show_video/show_video_binding.dart';
import 'package:muatmuat/app/modules/show_video/show_video_view.dart';
import 'package:muatmuat/app/modules/terms_and_conditions/terms_and_conditions_binding.dart';
import 'package:muatmuat/app/modules/terms_and_conditions/terms_and_conditions_view.dart';
import 'package:muatmuat/app/modules/test_list/test_list_binding.dart';
import 'package:muatmuat/app/modules/test_list/test_list_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/transporter/transporter_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/transporter/transporter_view.dart';
import 'package:muatmuat/app/modules/verify_email/verify_email_binding.dart';
import 'package:muatmuat/app/modules/verify_email/verify_email_view.dart';
import 'package:muatmuat/app/modules/verify_phone/verify_phone_binding.dart';
import 'package:muatmuat/app/modules/verify_phone/verify_phone_view.dart';
import 'package:muatmuat/app/modules/webview/webview_binding.dart';
import 'package:muatmuat/app/modules/webview/webview_view.dart';
import 'package:muatmuat/app/modules/webview_tac_pap/webview_tac_pap_binding.dart';
import 'package:muatmuat/app/modules/webview_tac_pap/webview_tac_pap_view.dart';
import 'package:muatmuat/app/modules/form_pendaftaran_bf/form_pendaftaran_perusahaan_binding.dart';
import 'package:muatmuat/app/modules/form_pendaftaran_bf/form_pendaftaran_bf_view.dart';
import 'package:muatmuat/app/modules/peta_bf_tm/search_location_map_bf_tm_view.dart';
import 'package:muatmuat/app/modules/peta_bf_tm/search_location_map_bf_tm_binding.dart';
import 'package:muatmuat/app/modules/profile_perusahaan/profile_perusahaan_binding.dart';
import 'package:muatmuat/app/modules/profile_perusahaan/profile_perusahaan_view.dart';
import 'package:muatmuat/app/modules/ubah_data_perusahaan/ubah_data_perusahaan_view.dart';
import 'package:muatmuat/app/tawkto/tawkto_binding.dart';
import 'package:muatmuat/app/template/main.dart';
import 'package:muatmuat/app/tawkto/tawkto_view.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/bigfleet3/bigfleets3_binding.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/bigfleet3/bigfleets3_view.dart';
import 'package:muatmuat/app/modules/bottom_navbar/notif_chat_view.dart';
import 'package:muatmuat/app/modules/bottom_navbar/notif_chat_binding.dart';

part 'app_routes.dart';

class AppPages {
  // PENYESUAIAN TEMPLATE
  static const INITIAL = Routes.INTRO;
  // static const INITIAL = 'template';
  // static const INITIAL = 'talkto';

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    // PENYESUAIAN TEMPLATE
    GetPage(name: 'template', page: () => MainPage()),
    //talkto
    // GetPage(
    //   name: 'talkto',
    //   page: () => TawktoView()
    // ),
    // GetPage(
    //   name: Routes.INTRO,
    //   page: () => IntroView(),
    //   binding: IntroBinding(),
    // ),
    GetPage(
      name: Routes.INTRO,
      page: () => IntroShipperView(),
      binding: IntroBindingShipper(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER_USER,
      page: () => RegisterView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.REGISTER_GOOGLE,
      page: () => RegisterGoogleView(),
      binding: RegisterUserBinding(),
    ),
    GetPage(
      name: Routes.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.OTP_FORGET_PASSWORD,
      page: () => OtpForgetPasswordView(),
      binding: OtpForgetPasswordBinding(),
    ),
    GetPage(
      name: Routes.CREATE_PASSWORD,
      page: () => CreatePasswordView(),
      binding: CreatePasswordBinding(),
    ),
    GetPage(
      name: Routes.SUCCESS_CREATE_PASSWORD,
      page: () => SuccessCreatePasswordView(),
      binding: SuccessCreatePasswordBinding(),
    ),
    GetPage(
      name: Routes.TERMS_AND_CONDITIONS_REGISTER,
      page: () => TermsAndConditionsRegisterView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: TermsAndConditionsRegisterBinding(),
    ),
    GetPage(
      name: Routes.PRIVACY_AND_POLICY_REGISTER,
      page: () => PrivacyPolicyRegisterView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: PrivacyPolicyRegisterBinding(),
    ),
    GetPage(
      name: Routes.OTP_PHONE_REGISTER,
      page: () => OtpPhoneView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: OtpPhoneBinding(),
    ),
    GetPage(
      name: Routes.SUCCESS_REGISTER,
      page: () => SuccessRegisterView(),
      binding: SuccessRegisterBinding(),
    ),
    GetPage(
      name: Routes.SETTING,
      page: () => SettingView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: SettingBinding(),
    ),
    GetPage(
      name: Routes.VERIFY_EMAIL,
      page: () => VerifyEmailView(),
      binding: VerifyEmailBinding(),
    ),
    GetPage(
      name: Routes.VERIFY_PHONE,
      page: () => VerifyPhoneView(),
      binding: VerifyPhoneBinding(),
    ),
    GetPage(
      name: Routes.TERMS_AND_CONDITIONS,
      page: () => TermsAndConditionsView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: TermsAndConditionsBinding(),
    ),
    GetPage(
      name: Routes.PRIVACY_AND_POLICY,
      page: () => PrivacyAndPolicyView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: PrivacyAndPolicyBinding(),
    ),
    GetPage(
      name: Routes.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATION,
      page: () => NotifViewNew(),
      binding: NotifBindingNew(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.PROFIL,
      page: () => ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: Routes.PENGATURAN_AKUN,
      page: () => PengaturanAkunView(),
      binding: PengaturanAkunBinding(),
    ),
    GetPage(
      name: Routes.ZONA_WAKTU_DAN_BAHASA,
      page: () => ZonaWaktuDanBahasaView(),
      binding: ZonaWaktuDanBahasaBinding(),
    ),
    GetPage(
      name: Routes.SYARAT_DAN_KEBIJAKAN,
      page: () => SyaratDanKebijakanView(),
      binding: SyaratDanKebijakanBinding(),
    ),
    GetPage(
      name: Routes.TAWKTO,
      page: () => TawktoView(),
      binding: TawktoBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.CONTACT_SUPPORT,
      page: () => SupportView(),
      binding: SupportBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.WEBVIEW,
      page: () => Webview(),
      binding: WebviewBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.BALANCE,
      page: () => BalanceView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: BalanceBinding(),
    ),
    GetPage(
      name: Routes.PAY,
      page: () => PayView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: PayBinding(),
    ),
    GetPage(
      name: Routes.FIND_TRUCK,
      page: () => FindTruckView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: FindTruckBinding(),
    ),
    GetPage(
      name: Routes.ARTICLE,
      page: () => ArticleView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: ArticleBinding(),
    ),
    GetPage(
      name: Routes.PRATENDER,
      page: () => PratenderView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: PratenderBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_PRATENDER,
      page: () => DetailPratenderView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: DetailPratenderBinding(),
    ),
    GetPage(
      name: Routes.PESERTA_PRATENDER,
      page: () => PesertaPratenderView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: PesertaPratenderBinding(),
    ),
    GetPage(
      name: Routes.CREATE_PRATENDER,
      page: () => CreatePratenderView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: CreatePratenderBinding(),
    ),
    GetPage(
      name: Routes.LOCATION_TRUCK_READY,
      page: () => LocationTruckReadyView(),
      binding: LocationTruckReadyBinding(),
    ),
    GetPage(
      name: Routes.FROM_DEST_SEARCH_LOCATION,
      page: () => FromDestSearchLocationView(),
      binding: FromDestSearchLocationBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_CITY,
      page: () => SearchCityView(),
      binding: SearchCityBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_LOCATION_MAP_MARKER,
      page: () => SearchLocationMapMarkerView(),
      binding: SearchLocationMapMarkerBinding(),
    ),
    GetPage(
      name: Routes.LOCATION_TRUCK_READY_SEARCH,
      page: () => LocationTruckReadySearchView(),
      binding: LocationTruckReadySearchBinding(),
    ),
    GetPage(
      name: Routes.PLACE_FAVORITE,
      page: () => PlaceFavoriteView(),
      binding: PlaceFavoriteBinding(),
    ),
    GetPage(
      name: Routes.PLACE_FAVORITE_CRUD,
      page: () => PlaceFavoriteCrudView(),
      binding: PlaceFavoriteCrudBinding(),
    ),
    GetPage(
      name: Routes.LIST_TRANSPORTER,
      page: () => ListTransporterView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: ListTransporterBinding(),
    ),
    GetPage(
      name: Routes.LIST_TRANSPORTER2,
      page: () => ListTransporterView(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 400),
      binding: ListTransporterBinding(),
    ),
    GetPage(
      name: Routes.TRANSPORTER,
      page: () => TransporterView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: TransporterBinding(),
    ),
    GetPage(
      name: Routes.MANAJEMEN_MITRA,
      page: () => ManajemenMitraView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: ManajemenMitraBinding(),
    ),
    GetPage(
      name: Routes.GROUP_MITRA,
      page: () => GroupMitraView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: GroupMitraBinding(),
    ),
    GetPage(
      name: Routes.CREATE_GROUP_MITRA,
      page: () => CreateGroupView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: CreateGroupBinding(),
    ),
    GetPage(
      name: Routes.CREATE_GROUP_MITRA_TAMBAH_ANGGOTA,
      page: () => CreateGroupTambahAnggotaView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: CreateGroupTambahAnggotaBinding(),
    ),
    GetPage(
      name: Routes.EDIT_GROUP_MITRA,
      page: () => EditGroupView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: EditGroupBinding(),
    ),
    GetPage(
      name: Routes.MANAJEMEN_ORDER_ENTRY,
      page: () => ManajemenOrderView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: ManajemenOrderBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_MANAJEMEN_ORDER_ENTRY,
      page: () => DetailManajemenOrderView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: DetailManajemenOrderBinding(),
    ),
    GetPage(
      name: Routes.CREATE_ORDER_ENTRY,
      page: () => CreateOrderEntryView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: CreateOrderEntryBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_PERMINTAAN_MUAT,
      page: () => DetailPermintaanMuatView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: DetailPermintaanMuatBinding(),
    ),
    GetPage(
      name: Routes.MAP_DETAIL_PERMINTAAN_MUAT,
      page: () => MapDetailPermintaanMuatComponent(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.CREATE_PERMINTAAN_MUAT,
      page: () => CreatePermintaanMuatView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: CreatePermintaanMuatBinding(),
    ),
    GetPage(
      name: Routes.BIGFLEETS,
      page: () => BigfleetsView(),
      binding: BigfleetsBinding(),
    ),
    GetPage(
      name: Routes.SHIPPER_BUYER_REGISTER,
      page: () => ShipperBuyerRegisterView(),
      binding: ShipperBuyerRegisterBinding(),
    ),
    GetPage(
      name: Routes.SHIPPER_BUYER_REGISTER_SUCCESS,
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      page: () => ShipperBuyerRegisterSuccessView(),
      binding: ShipperBuyerRegisterSuccessBinding(),
    ),
    GetPage(
      name: Routes.CHOOSE_USER_TYPE,
      page: () => ChooseUserTypeView(),
      binding: ChooseUserTypeBinding(),
    ),
    GetPage(
      name: Routes.USER_TYPE_INFORMATION,
      page: () => UserTypeInformationView(),
      binding: UserTypeInformationBinding(),
    ),
    GetPage(
      name: Routes.WEBVIEW_TAC_PAP,
      page: () => WebviewTacPapView(),
      binding: WebviewTacPapBinding(),
    ),
    GetPage(
      name: Routes.BIGFLEETS2,
      page: () => Bigfleets2View(),
      binding: Bigfleets2Binding(),
    ),
    GetPage(
      name: Routes.BIGFLEETS3,
      page: () => Bigfleets3View(),
      binding: Bigfleets3Binding(),
    ),
    GetPage(
      name: Routes.DETAIL_MANAJEMEN_GROUP_MITRA,
      page: () => DetailManajemenGroupMitraView(),
      binding: DetailManajemenGroupMitraBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_DETAIL_MANAJEMEN_GROUP_MITRA,
      page: () => SearchDetailManajemenGroupMitraView(),
      binding: SearchDetailManajemenGroupMitraBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_MANAJEMEN_GROUP_TAMBAH_ANGGOTA,
      page: () => DetailManajemenGroupTambahAnggotaView(),
      binding: DetailManajemenGroupTambahAnggotaBinding(),
    ),
    GetPage(
      name: Routes.CAROUSEL_GALLERY,
      page: () => CarouselGalleryView(),
      binding: CarouselGalleryBinding(),
    ),
    GetPage(
      name: Routes.SHOW_VIDEO,
      page: () => ShowVideoView(),
      binding: ShowVideoBinding(),
    ),
    GetPage(
      name: Routes.RESET_PASSWORD_SUCCESS,
      page: () => ResetPasswordSuccessView(),
      binding: ResetPasswordSuccessBinding(),
    ),
    GetPage(
      name: Routes.PROFILE_SHIPPER,
      page: () => ProfileShipperView(),
      binding: ProfileShipperBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_PROFIL_SHIPPER,
      page: () => DetailProfilShipperView(),
      binding: DetailProfilShipperBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_PROFIL_SHIPPER_COMPANY,
      page: () => DetailProfilShipperCompanyView(),
      binding: DetailProfilShipperCompanyBinding(),
    ),
    GetPage(
      name: Routes.TEST_LIST,
      page: () => TestListView(),
      binding: TestListBinding(),
    ),
    GetPage(
      name: Routes.LIST_CITY_FILTER,
      page: () => ListCityFilterView(),
      binding: ListCityFilterBinding(),
    ),
    GetPage(
      name: Routes.MAP_DETAIL_TRANSPORTER,
      page: () => MapDetailTransporterView(),
      binding: MapDetailTransporterBinding(),
    ),
    GetPage(
      name: Routes.LIST_INFO_PERMINTAAN_MUAT,
      page: () => ListInfoPermintaanMuatView(),
      binding: ListInfoPermintaanMuatBinding(),
    ),
    GetPage(
      name: Routes.LIST_USER_INFO_PERMINTAAN_MUAT,
      page: () => ListUserInfoPermintaanMuatView(),
      binding: ListUserInfoPermintaanMuatBinding(),
    ),
    GetPage(
      name: Routes.LIST_TRUCK_CARRIER_FILTER,
      page: () => ListTruckCarrierFilterView(),
      binding: ListTruckCarrierFilterBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_MANAJEMEN_MITRA,
      page: () => SearchManajemenMitraView(),
      binding: SearchManajemenMitraBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_RESULT_MANAJEMEN_MITRA,
      page: () => SearchResultManajemenMitraView(),
      binding: SearchResultManajemenMitraBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_INFO_PERMINTAAN_MUAT,
      page: () => SearchInfoPermintaanMuatView(),
      binding: SearchInfoPermintaanMuatBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_RESULT_INFO_PERMINTAAN_MUAT,
      page: () => SearchResultInfoPermintaanMuatView(),
      binding: SearchResultInfoPermintaanMuatBinding(),
    ),
    GetPage(
      name: Routes.SELECT_HEAD_CARRIER_TRUCK_INTERNAL,
      page: () => SelectHeadCarrierView(),
      binding: SelectHeadCarrierBinding(),
    ),
    GetPage(
      name: Routes.SELECT_LIST_LOKASI,
      page: () => SelectListLokasiView(),
      binding: SelectListLokasiBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_LOCATION_INFO_PERMINTAAN_MUAT,
      page: () => SearchLocationInfoPermintaanMuatView(),
      binding: SearchLocationInfoPermintaanMuatBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_MANAJEMEN_LOKASI_INFO_PERMINTAAN_MUAT,
      page: () => SearchManajemenLokasiInfoPermintaanMuatView(),
      binding: SearchManajemenLokasiInfoPermintaanMuatBinding(),
    ),
    GetPage(
      name: Routes.EDIT_MANAJEMEN_LOKASI_INFO_PERMINTAAN_MUAT,
      page: () => EditManajemenLokasiInfoPermintaanMuatView(),
      binding: EditManajemenLokasiInfoPermintaanMuatBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_LIST_TRANSPORTER,
      page: () => SearchListTransporterView(),
      binding: SearchListTransporterBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_RESULT_LIST_TRANSPORTER,
      page: () => SearchResultListTransporterView(),
      binding: SearchResultListTransporterBinding(),
    ),
    GetPage(
      name: Routes.LIST_USER,
      page: () => ListUserView(),
      binding: ListUserBinding(),
    ),
    GetPage(
      name: Routes.ERROR_REGISTER_EMAIL_STILL_VERIFY,
      page: () => ErrorRegisterEmailStillVerifyView(),
      binding: ErrorRegisterEmailStillVerifyBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_LTSM,
      page: () => DetailLTSMView(),
      binding: DetailLTSMBinding(),
    ),
    GetPage(
      name: Routes.LOKASI_TRUK_SIAP_MUAT,
      page: () => LokasiTrukSiapMuatView(),
      binding: LokasiTrukSiapMuatBinding(),
    ),
    GetPage(
      name: Routes.CHOOSE_AREA_PICKUP_INTERNAL,
      page: () => ChooseAreaPickupInternalView(),
      binding: ChooseAreaPickupInternalBinding(),
    ),
    GetPage(
      name: Routes.LIST_SEARCH_TRUCK_SIAP_MUAT,
      page: () => ListSearchTruckSiapMuatView(),
      binding: ListSearchTruckSiapMuatBinding(),
    ),
    GetPage(
      name: Routes.CHOOSE_EKSPETASI_DESTINASI,
      page: () => ChooseEkspetasiDestinasiView(),
      binding: ChooseEkspetasiDestinasiBinding(),
    ),
    GetPage(
      name: Routes.LIST_AREA_PICKUP_SEARCH_FILTER,
      page: () => ListAreaPickupSearchFilterView(),
      binding: ListAreaPickupSearchFilterBinding(),
    ),
    GetPage(
      name: Routes.LIST_AREA_PICKUP_TRANSPORTER_FILTER,
      page: () => ListAreaPickupTransporterFilterView(),
      binding: ListAreaPickupTransporterFilterBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_LOCATION_LOKASI_TRUK_SIAP_MUAT,
      page: () => SearchLocationLokasiTrukSiapMuatView(),
      binding: SearchLocationLokasiTrukSiapMuatBinding(),
    ),
    GetPage(
      name: Routes.LIST_MANAGEMENT_LOKASI,
      page: () => ListManagementLokasiView(),
      binding: ListManagementLokasiBinding(),
    ),
    GetPage(
      name: Routes.FILTER_MANAJEMEN_LOKASI,
      page: () => FilterManajemenLokasiView(),
      binding: FilterManajemenLokasiBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_LIST_MANAGEMENT_LOKASI,
      page: () => SearchListManagementLokasiView(),
      binding: SearchListManagementLokasiBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_RESULT_LIST_MANAGEMENT_LOKASI,
      page: () => SearchResultListManagementLokasiView(),
      binding: SearchResultListManagementLokasiBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_LOCATION_ADD_EDIT_MANAJEMEN_LOKASI,
      page: () => SearchLocationAddEditManajemenLokasiView(),
      binding: SearchLocationAddEditManajemenLokasiBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_MANAJEMEN_LOKASI,
      page: () => DetailManajemenLokasiView(),
      binding: DetailManajemenLokasiBinding(),
    ),
    GetPage(
      name: Routes.MAP_MANAGEMENT_LOKASI,
      page: () => MapManagementLokasiView(),
      binding: MapManagementLokasiBinding(),
    ),

    //bigfleet subscription
    GetPage(
      name: Routes.TERMS_AND_CONDITIONS_SUBSCRIPTION,
      page: () => TermsAndConditionsSubscriptionView(),
      binding: TermsAndConditionsSubscriptionBinding(),
    ),
    GetPage(
      name: Routes.CREATE_SUBSCRIPTION,
      page: () => CreateSubscriptionView(),
      binding: CreateSubscriptionBinding(),
    ),
    GetPage(
      name: Routes.SUBSCRIPTION_HOME,
      page: () => SubscriptionHomeView(),
      binding: SubscriptionHomeBinding(),
    ),
    GetPage(
      name: Routes.CHOOSE_SUBUSER,
      page: () => ChooseSubuserView(),
      binding: ChooseSubuserBinding(),
    ),
    GetPage(
      name: Routes.CHOOSE_VOUCHER,
      page: () => ChooseVoucherView(),
      binding: ChooseVoucherBinding(),
    ),
    GetPage(
      name: Routes.SUBSCRIPTION_RIWAYAT_LANGGANAN_BF_DAN_SU_LIST,
      page: () => SubscriptionRiwayatLanggananBFDanSUListView(),
      binding: SubscriptionRiwayatLanggananBFDanSUListBinding(),
    ),
    GetPage(
      name: Routes.SUBSCRIPTION_RIWAYAT_LANGGANAN_BF_LIST_SEARCH,
      page: () => SubscriptionRiwayatLanggananBFListSearchView(),
      binding: SubscriptionRiwayatLanggananBFListSearchBinding(),
    ),
    GetPage(
      name: Routes.SUBSCRIPTION_RIWAYAT_LANGGANAN_BF_LIST_SEARCH_RESULT,
      page: () => SubscriptionRiwayatLanggananBFListSearchResultView(),
      binding: SubscriptionRiwayatLanggananBFListSearchResultBinding(),
    ),
    GetPage(
      name: Routes.SUBSCRIPTION_RIWAYAT_LANGGANAN_SU_LIST_SEARCH,
      page: () => SubscriptionRiwayatLanggananSUListSearchView(),
      binding: SubscriptionRiwayatLanggananSUListSearchBinding(),
    ),
    GetPage(
      name: Routes.SUBSCRIPTION_RIWAYAT_LANGGANAN_SU_LIST_SEARCH_RESULT,
      page: () => SubscriptionRiwayatLanggananSUListSearchResultView(),
      binding: SubscriptionRiwayatLanggananSUListSearchResultBinding(),
    ),
    GetPage(
      name: Routes.SUBSCRIPTION_DETAIL,
      page: () => SubscriptionDetailView(),
      binding: SubscriptionDetailBinding(),
    ),
    GetPage(
      name: Routes.CREATE_SUBUSER,
      page: () => CreateSubuserView(),
      binding: CreateSubuserBinding(),
    ),
    GetPage(
      name: Routes.SUBSCRIPTION_MENUNGGU_PEMBAYARAN_LIST,
      page: () => SubscriptionMenungguPembayaranListView(),
      binding: SubscriptionMenungguPembayaranListBinding(),
    ),
    GetPage(
      name: Routes.SUBSCRIPTION_MENUNGGU_PEMBAYARAN_LIST_SEARCH,
      page: () => SubscriptionMenungguPembayaranListSearchView(),
      binding: SubscriptionMenungguPembayaranListSearchBinding(),
    ),
    GetPage(
      name: Routes.SUBSCRIPTION_MENUNGGU_PEMBAYARAN_LIST_SEARCH_RESULT,
      page: () => SubscriptionMenungguPembayaranListSearchResultView(),
      binding: SubscriptionMenungguPembayaranListSearchResultBinding(),
    ),
    GetPage(
      name: Routes.SUBSCRIPTION_RIWAYAT_PESANAN_LIST,
      page: () => SubscriptionRiwayatPesananListView(),
      binding: SubscriptionRiwayatPesananListBinding(),
    ),
    GetPage(
      name: Routes.SUBSCRIPTION_RIWAYAT_PESANAN_LIST_SEARCH,
      page: () => SubscriptionRiwayatPesananListSearchView(),
      binding: SubscriptionRiwayatPesananListSearchBinding(),
    ),
    GetPage(
      name: Routes.SUBSCRIPTION_RIWAYAT_PESANAN_LIST_SEARCH_RESULT,
      page: () => SubscriptionRiwayatPesananListSearchResultView(),
      binding: SubscriptionRiwayatPesananListSearchResultBinding(),
    ),
    GetPage(
      name: Routes.SUBSCRIPTION_PILIH_METODE_PEMBAYARAN,
      page: () => SubscriptionPilihMetodePembayaranView(),
      binding: SubscriptionPilihMetodePembayaranBinding(),
    ),
    GetPage(
      name: Routes.KARTU_KREDIT_DEBIT_ONLINE,
      page: () => KartuKreditDebitOnlineView(),
      binding: KartuKreditDebitOnlineBinding(),
    ),
    GetPage(
      name: Routes.PEMBAYARAN_SUBSCRIPTION,
      page: () => PembayaranSubscriptionView(),
      binding: PembayaranSubscriptionBinding(),
    ),

    GetPage(
      name: Routes.NOTIF_CHAT_SCREEN,
      page: () => NotifChatView(),
      binding: NotifChatBinding(),
    ),

    GetPage(
      name: Routes.INSTANT_ORDER,
      page: () => InstantOrderView(),
      binding: InstantOrderBinding(),
    ),
    // //transport market
    // GetPage(
    //   name: Routes.TRANSPORT_MARKET,
    //   page: () => TransportMarketView(),
    //   binding: TransportMarketBinding(),
    // ),

    //transport market subscription
    GetPage(
      name: Routes.TM_TERMS_AND_CONDITIONS_SUBSCRIPTION,
      page: () => TMTermsAndConditionsSubscriptionView(),
      binding: TMTermsAndConditionsSubscriptionBinding(),
    ),
    GetPage(
      name: Routes.TM_CREATE_SUBSCRIPTION,
      page: () => TMCreateSubscriptionView(),
      binding: TMCreateSubscriptionBinding(),
    ),
    GetPage(
      name: Routes.TM_SUBSCRIPTION_HOME,
      page: () => TMSubscriptionHomeView(),
      binding: TMSubscriptionHomeBinding(),
    ),
    GetPage(
      name: Routes.TM_CHOOSE_SUBUSER,
      page: () => TMChooseSubuserView(),
      binding: TMChooseSubuserBinding(),
    ),
    GetPage(
      name: Routes.TM_CHOOSE_VOUCHER,
      page: () => TMChooseVoucherView(),
      binding: TMChooseVoucherBinding(),
    ),
    GetPage(
      name: Routes.TM_SUBSCRIPTION_RIWAYAT_LANGGANAN_BF_DAN_SU_LIST,
      page: () => TMSubscriptionRiwayatLanggananBFDanSUListView(),
      binding: TMSubscriptionRiwayatLanggananBFDanSUListBinding(),
    ),
    GetPage(
      name: Routes.TM_SUBSCRIPTION_RIWAYAT_LANGGANAN_BF_LIST_SEARCH,
      page: () => TMSubscriptionRiwayatLanggananBFListSearchView(),
      binding: TMSubscriptionRiwayatLanggananBFListSearchBinding(),
    ),
    GetPage(
      name: Routes.TM_SUBSCRIPTION_RIWAYAT_LANGGANAN_BF_LIST_SEARCH_RESULT,
      page: () => TMSubscriptionRiwayatLanggananBFListSearchResultView(),
      binding: TMSubscriptionRiwayatLanggananBFListSearchResultBinding(),
    ),
    GetPage(
      name: Routes.TM_SUBSCRIPTION_RIWAYAT_LANGGANAN_SU_LIST_SEARCH,
      page: () => TMSubscriptionRiwayatLanggananSUListSearchView(),
      binding: TMSubscriptionRiwayatLanggananSUListSearchBinding(),
    ),
    GetPage(
      name: Routes.TM_SUBSCRIPTION_RIWAYAT_LANGGANAN_SU_LIST_SEARCH_RESULT,
      page: () => TMSubscriptionRiwayatLanggananSUListSearchResultView(),
      binding: TMSubscriptionRiwayatLanggananSUListSearchResultBinding(),
    ),
    GetPage(
      name: Routes.TM_SUBSCRIPTION_DETAIL,
      page: () => TMSubscriptionDetailView(),
      binding: TMSubscriptionDetailBinding(),
    ),
    GetPage(
      name: Routes.TM_CREATE_SUBUSER,
      page: () => TMCreateSubuserView(),
      binding: TMCreateSubuserBinding(),
    ),
    GetPage(
      name: Routes.TM_SUBSCRIPTION_MENUNGGU_PEMBAYARAN_LIST,
      page: () => TMSubscriptionMenungguPembayaranListView(),
      binding: TMSubscriptionMenungguPembayaranListBinding(),
    ),
    GetPage(
      name: Routes.TM_SUBSCRIPTION_MENUNGGU_PEMBAYARAN_LIST_SEARCH,
      page: () => TMSubscriptionMenungguPembayaranListSearchView(),
      binding: TMSubscriptionMenungguPembayaranListSearchBinding(),
    ),
    GetPage(
      name: Routes.TM_SUBSCRIPTION_MENUNGGU_PEMBAYARAN_LIST_SEARCH_RESULT,
      page: () => TMSubscriptionMenungguPembayaranListSearchResultView(),
      binding: TMSubscriptionMenungguPembayaranListSearchResultBinding(),
    ),
    GetPage(
      name: Routes.TM_SUBSCRIPTION_RIWAYAT_PESANAN_LIST,
      page: () => TMSubscriptionRiwayatPesananListView(),
      binding: TMSubscriptionRiwayatPesananListBinding(),
    ),
    GetPage(
      name: Routes.TM_SUBSCRIPTION_RIWAYAT_PESANAN_LIST_SEARCH,
      page: () => TMSubscriptionRiwayatPesananListSearchView(),
      binding: TMSubscriptionRiwayatPesananListSearchBinding(),
    ),
    GetPage(
      name: Routes.TM_SUBSCRIPTION_RIWAYAT_PESANAN_LIST_SEARCH_RESULT,
      page: () => TMSubscriptionRiwayatPesananListSearchResultView(),
      binding: TMSubscriptionRiwayatPesananListSearchResultBinding(),
    ),
    GetPage(
      name: Routes.TM_SUBSCRIPTION_PILIH_METODE_PEMBAYARAN,
      page: () => TMSubscriptionPilihMetodePembayaranView(),
      binding: TMSubscriptionPilihMetodePembayaranBinding(),
    ),
    GetPage(
      name: Routes.TM_KARTU_KREDIT_DEBIT_ONLINE,
      page: () => TMKartuKreditDebitOnlineView(),
      binding: TMKartuKreditDebitOnlineBinding(),
    ),
    GetPage(
      name: Routes.TM_PEMBAYARAN_SUBSCRIPTION,
      page: () => TMPembayaranSubscriptionView(),
      binding: TMPembayaranSubscriptionBinding(),
    ),

    // REGISTER BF/TM
    GetPage(
      name: Routes.REGISTER_PERUSAHAAN_BF,
      page: () => FormPendaftaranPerusahaanView(),
      binding: FormPendaftaranBFBinding(),
    ),
    // GetPage(
    //   name: Routes.OTP_NOHP,
    //   page: () => OtpNohpView(),
    //   // transition: Transition.rightToLeft,
    //   // transitionDuration: Duration(milliseconds: 400),
    //   binding: OtpNohpBinding(),
    // ),
    // GetPage(
    //   name: Routes.LOGIN_SHIPPER,
    //   page: () => LoginSellerView(),
    //   binding: LoginSellerBinding(),
    // ),

    GetPage(
      name: Routes.UPLOAD_PICTURE,
      page: () => UploadPictureView(),
      binding: UploadPictureBinding(),
    ),
    GetPage(
      name: Routes.UPLOAD_LEGALITAS,
      page: () => UploadLegalitasView(),
      binding: UploadLegalitasBinding(),
    ),
    GetPage(
        name: Routes.SHIPMENT_CAPACITY_VALIDATION,
        page: () => ShipmentCapacityValidationView(),
        binding: ShipmentCapacityValidationBinding()),
    GetPage(
        name: Routes.FILE_EXAMPLE,
        page: () => FileExample(),
        binding: FileExampleBinding()),
    GetPage(
        name: Routes.CHOOSE_BUSINESS_FIELD,
        page: () => ChooseBusinessFieldView(),
        binding: ChooseBusinessFieldBinding()),
    GetPage(
        name: Routes.CHOOSE_DISTRICT,
        page: () => ChooseDistrictView(),
        binding: ChooseDistrictBinding()),
    GetPage(
        name: Routes.LOKASI_BF_TM,
        page: () => LokasiBFTMView(),
        binding: LokasiBFTMBinding()),
    GetPage(
        name: Routes.SEARCH_LOCATION_BF_TM,
        page: () => SearchLocationBFTM(),
        binding: SearchLocationBFTMBinding()),
    GetPage(
        name: Routes.TERMS_AND_CONDITIONS_BFTM,
        page: () => TermsAndConditionsBFTMView(),
        binding: TermsAndConditionsBFTMBinding()),
    GetPage(
        name: Routes.SUCCESS_REGISTER_BFTM, 
        page: () => SuccessRegisterBFTM()),
    GetPage(
        name: Routes.FAKE_HOME, 
        page: () => FakeHome(),
        binding: FakeHomeBinding()),
    GetPage(
        name: Routes.PETA_BF_TM,
        page: () => PetaBFTMView(),
        binding: PetaBFTMBinding()),
    GetPage(
        name: Routes.OTP_EMAIL,
        page: () => OtpEmailBFTMView(),
        binding: OtpEmailBFTMBinding()),
    GetPage(
        name: Routes.REGISTER_SHIPPER_BF_TM,
        page: () => RegisterShipperBfTmView(),
        binding: RegisterShipperBfTmBinding()),

    /* PROFILE */
    GetPage(
        name: Routes.PROFILE_PERUSAHAAN,
        page: () => ProfilePerusahaanView(),
        binding: ProfilePerusahaanBinding()),
    GetPage(
      name: Routes.PROFILE_PERUSAHAAN_VIEW_LOCATION,
      page: () => PetaLokasiProfilePerusahaanView(),
    ),
    GetPage(
      name: Routes.UBAH_KELENGKAPAN_LEGALITAS,
      page: () => UbahKelengkapanLegalitasView(),
      binding: UbahKelengkapanLegalitasBinding(),
    ),
    GetPage(
      name: Routes.TESTIMONI_PROFILE,
      page: () => TestimoniProfileView(),
      binding: TestimoniProfileBinding(),
    ),
    GetPage(
      name: Routes.UBAH_TESTIMONI_PROFILE,
      page: () => UbahTestimoniProfileView(),
      binding: UbahTestimoniProfileBinding(),
    ),
    GetPage(
      name: Routes.UBAH_DATA_PERUSAHAAN,
      page: () => UbahDataPerusahaanView(),
      binding: UbahDataPerusahaanBinding(),
    ),
    GetPage(
      name: Routes.UBAH_KONTAK_PIC,
      page: () => UbahKontakPicView(),
      binding: UbahKontakPicBinding(),
    ),
    GetPage(
      name: Routes.UBAH_FOTO_PROFIL,
      page: () => UbahFotoProfilView(),
      binding: UbahFotoProfilBinding(),
    ),
    GetPage(
      name: Routes.UBAH_LOGO_PERUSAHAAN,
      page: () => UbahLogoPerusahaanView(),
      binding: UbahLogoPerusahaanBinding(),
    ),
    GetPage(
      name: Routes.LOKASI_PROFIL_PERUSAHAAN,
      page: () => LokasiUbahDataView(),
      binding: LokasiUbahDataBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_LOCATION_UBAH_DATA,
      page: () => SearchLocationUbahDataView(),
      binding: SearchLocationUbahDataBinding(),
    ),
    GetPage(
      name: Routes.PETA_UBAH_DATA,
      page: () => SearchLocationUbahDataMapView(),
      binding: SearchLocationUbahDataMapBinding(),
    ),
    GetPage(
      name: Routes.DATA_KAPASITAS_PENGIRIMAN,
      page: () => DataKapasitasPengirimanView(),
      binding: DataKapasitasPengirimanBinding(),
    ),
    GetPage(
        name: Routes.OTP_PROFILE,
        page: () => OtpProfileView(),
        binding: OtpProfileBinding()),
    GetPage(
        name: Routes.OTP_PHONE_PROFILE,
        page: () => OtpPhoneProfileView(),
        binding: OtpPhoneProfileBinding()),
    GetPage(
        name: Routes.OTP_EMAIL_PROFILE,
        page: () => OtpEmailProfileView(),
        binding: OtpEmailProfileBinding()),

    GetPage(
        name: Routes.FORM_PHONE_PROFILE,
        page: () => FormPhoneProfileView(),
        binding: FormPhoneProfileBinding()),
    GetPage(
        name: Routes.FORM_EMAIL_PROFILE,
        page: () => FormEmailProfileView(),
        binding: FormEmailProfileBinding()),
    GetPage(
        name: Routes.FORM_PASSWORD_PROFILE,
        page: () => FormPasswordProfileView(),
        binding: FormPasswordProfileBinding()),
    GetPage(
        name: Routes.FORM_INPUT_PASSWORD_PROFILE,
        page: () => FormInputPasswordProfileView(),
        binding: FormInputPasswordProfileBinding()),
    GetPage(
      name: Routes.NOTIF,
      page: () => NotifViewNew(),
      binding: NotifBindingNew(),
    ),
    GetPage(
      name: Routes.BEFORE_LOGIN_USER,
      page: () => BeforeLoginUserView(),
      binding: BeforeLoginUserBinding(),
    ),
    GetPage(
      name: Routes.CHOOSE_DISTRICT_PROFIL_PERUSAHAAN,
      page: () => ChooseDistrictProfilPerusahaanView(),
      binding: ChooseDistrictProfilPerusahaanBinding(),
    ),
    GetPage(
      name: Routes.PROFILE_INDIVIDU,
      page: () => ProfileIndividuView(),
      binding: ProfileIndividuBinding(),
    ),
    GetPage(
      name: Routes.UBAH_KELENGKAPAN_LEGALITAS_INDIVIDU,
      page: () => UbahKelengkapanLegalitasIndividuView(),
      binding: UbahKelengkapanLegalitasIndividuBinding(),
    ),

    GetPage(
      name: Routes.MANAJEMEN_NOTIFIKASI,
      page: () => ManajemenNotifikasiView(),
      binding: ManajemenNotifikasiBinding(),
    ),
    GetPage(
      name: Routes.MANAJEMEN_NOTIFIKASI_EMAIL,
      page: () => ManajemenNotifikasiEmailView(),
      binding: ManajemenNotifikasiEmailBinding(),
    ),
    GetPage(
      name: Routes.MANAJEMEN_NOTIFIKASI_APLIKASI,
      page: () => ManajemenNotifikasiAplikasiView(),
      binding: ManajemenNotifikasiAplikasiBinding(),
    ),
    GetPage(
      name: Routes.RINGKASAN_MANAJEMEN_NOTIFIKASI,
      page: () => RingkasanManajemenNotifikasiView(),
      binding: RingkasanManajemenNotifikasiBinding(),
    ),
    GetPage(
      name: Routes.REPORT,
      page: () => ReportView(),
      binding: ReportBinding()
    ),
    GetPage(
      name: Routes.TESTIMONI,
      page: () => TestimoniView(),
      binding: TestimoniBinding()
    ),
    GetPage(
      name: Routes.UBAH_DATA_USAHA,
      page: () => UbahDataUsahaView(),
      binding: UbahDataUsahaBinding(),
    ),
    GetPage(
      name: Routes.UBAH_DATA_PRIBADI,
      page: () => UbahDataPribadiView(),
      binding: UbahDataPribadiBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_KECAMATAN,
      page: () => SearchKecamatanView(),
      binding: SearchKecamatanBinding(),
    ),
    GetPage(
      name: Routes.BAHASA_PLACEHOLDER,
      page: () => BahasaPlaceholderView(),
      binding: BahasaPlaceholderBinding(),
    ),
    GetPage(
      name: Routes.KONTAK_PIC,
      page: () => KontakPICView(),
      binding: KontakPICBinding(),
    ),
    GetPage(
      name: Routes.TENTANG_PERUSAHAAN,
      page: () => TentangPerusahaanView(),
      binding: TentangPerusahaanBinding(),
    ),
    GetPage(
      name: Routes.DATA_ARMADA,
      page: () => DataArmadaView(),
      binding: DataArmadaBinding(),
    ),
    GetPage(
      name: Routes.FOTO_VIDEO,
      page: () => FotoDanVideoView(),
      binding: FotoDanVideoBindings(),
    ),
    
    GetPage(
      name: Routes.SEARCH_LOCATION_UBAH_DATA_USAHA,
      page: () => SearchLocationDataUsahaView(),
      binding: SearchLocationDataUsahaBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_LOCATION_UBAH_DATA_PRIBADI,
      page: () => SearchLocationDataPribadiView(),
      binding: SearchLocationDataPribadiBinding(),
    ),
    GetPage(
      name: Routes.LOKASI_UBAH_DATA_INDIVIDU,
      page: () => LokasiUbahDataIndividuView(),
      binding: LokasiUbahDataIndividuBinding(),
    ),

    GetPage(
      name: Routes.LOKASI_UBAH_DATA_INDIVIDU_PRIBADI,
      page: () => LokasiUbahDataIndividuPribadiView(),
      binding: LokasiUbahDataIndividuPribadiBinding(),
    ),
    GetPage(
      name: Routes.PETA_UBAH_DATA_USAHA,
      page: () => SearchLocationMapMarkerDataUsahaView(),
      binding: SearchLocationMapMarkerDataUsahaBinding(),
    ),
    GetPage(
      name: Routes.PETA_UBAH_DATA_PRIBADI,
      page: () => SearchLocationMapMarkerDataPribadiView(),
      binding: SearchLocationMapMarkerDataPribadiBinding(),
    ),
    GetPage(
      name: Routes.UBAH_LOGO_INDIVIDU,
      page: () => UbahLogoIndividuView(),
      binding: UbahLogoIndividuBinding(),
    ),
    //////////
    ///ARK<///
    //////////

    GetPage(
      name: Routes.CHOOSE_AREA_PICKUP,
      page: () => ChooseAreaPickupView(),
      binding: ChooseAreaPickupBinding(),
    ),
    GetPage(
      name: Routes.SELECT_HEAD_CARRIER_TRUCK,
      page: () => arkshcv.SelectHeadCarrierView(),
      binding: arkshcb.SelectHeadCarrierBinding(),
    ),
    GetPage(
      name: Routes.LIHAT_PDF,
      page: () => LihatPDF(),
      binding: LihatPDFBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
    ),

    //MASUK MENU TENDER
    GetPage(
      name: Routes.TENDER,
      page: () => TenderView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: TenderBinding(),
    ),
    GetPage(
      name: Routes.INFO_PRA_TENDER,
      page: () => InfoPraTenderView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: InfoPraTenderBinding(),
    ),
    GetPage(
      name: Routes.PROSES_TENDER,
      page: () => ProsesTenderView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: ProsesTenderBinding(),
    ),
    GetPage(
      name: Routes.PEMENANG_TENDER,
      page: () => PemenangTenderView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: PemenangTenderBinding(),
    ),

    //MASUK INFO PRA TENDER
    GetPage(
      name: Routes.CREATE_INFO_PRA_TENDER,
      page: () => CreateInfoPraTenderView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: CreateInfoPraTenderBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_INFO_PRA_TENDER,
      page: () => DetailInfoPraTenderView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: DetailInfoPraTenderBinding(),
    ),
    GetPage(
      name: Routes.EDIT_INFO_PRA_TENDER,
      page: () => EditInfoPraTenderView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: EditInfoPraTenderBinding(),
    ),
    //MASUK INFO PRA TENDER

    //MASUK PROSES TENDER
    GetPage(
      name: Routes.CREATE_PROSES_TENDER,
      page: () => CreateProsesTenderView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: CreateProsesTenderBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_PROSES_TENDER,
      page: () => DetailProsesTenderView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: DetailProsesTenderBinding(),
    ),
    GetPage(
      name: Routes.EDIT_PROSES_TENDER,
      page: () => EditProsesTenderView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: EditProsesTenderBinding(),
    ),
    //MASUK PROSES TENDER

    GetPage(
      name: Routes.INFORMASI_PROSES_TENDER,
      page: () => InformasiProsesTenderView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: InformasiProsesTenderBinding(),
    ),

    //LIST TENTUKAN PEMENANG TENDER
    GetPage(
      name: Routes.LIST_TENTUKAN_PEMENANG_TENDER,
      page: () => ListTentukanPemenangTenderView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: ListTentukanPemenangTenderBinding(),
    ),

    //HALAMAN PESERTA
    GetPage(
      name: Routes.LIST_HALAMAN_PESERTA,
      page: () => ListHalamanPesertaView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: ListHalamanPesertaBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_LIST_HALAMAN_PESERTA,
      page: () => SearchListHalamanPesertaView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: SearchListHalamanPesertaBinding(),
    ),
    GetPage(
      name: Routes.LIST_HALAMAN_PESERTA_DETAIL_KEBUTUHAN,
      page: () => ListHalamanPesertaDetailKebutuhanView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: ListHalamanPesertaDetailKebutuhanBinding(),
    ),
    GetPage(
      name: Routes.LIST_HALAMAN_PESERTA_DETAIL_PENAWARAN,
      page: () => ListHalamanPesertaDetailPenawaranView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: ListHalamanPesertaDetailPenawaranBinding(),
    ),
    GetPage(
      name: Routes.LIST_HALAMAN_PESERTA_PILIH_PEMENANG,
      page: () => ListHalamanPesertaPilihPemenangView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: ListHalamanPesertaPilihPemenangBinding(),
    ),
    GetPage(
      name: Routes.LIST_HALAMAN_PESERTA_DETAIL_PEMENANG,
      page: () => ListHalamanPesertaDetailPemenangView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: ListHalamanPesertaDetailPemenangBinding(),
    ),
    //HALAMAN PESERTA

    //PILIH PEMENANG
    GetPage(
      name: Routes.LIST_PILIH_PEMENANG,
      page: () => ListPilihPemenangView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: ListPilihPemenangBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_LIST_PILIH_PEMENANG,
      page: () => SearchListPilihPemenangView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: SearchListPilihPemenangBinding(),
    ),
    GetPage(
      name: Routes.LIST_PILIH_PEMENANG_TELAH_DIPILIH,
      page: () => ListPilihPemenangTelahDipilihView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      binding: ListPilihPemenangTelahDipilihBinding(),
    ),
    //PILIH PEMENANG

    GetPage(
      name: Routes.LIST_MUATAN_FILTER,
      page: () => ListMuatanFilterView(),
      binding: ListMuatanFilterBinding(),
    ),
    GetPage(
      name: Routes.LIST_DIUMUMKAN_KEPADA_FILTER,
      page: () => ListDiumumkanKepadaFilterView(),
      binding: ListDiumumkanKepadaFilterBinding(),
    ),
    GetPage(
      name: Routes.LIST_PROVINCE_FILTER_ARK,
      page: () => ListProvinceFilterArkView(),
      binding: ListProvinceFilterArkBinding(),
    ),
    GetPage(
      name: Routes.LIST_CARRIER_FILTER_ARK,
      page: () => ListCarrierFilterArkView(),
      binding: ListCarrierFilterArkBinding(),
    ),
    GetPage(
      name: Routes.LIST_TRUCK_FILTER_ARK,
      page: () => ListTruckFilterArkView(),
      binding: ListTruckFilterArkBinding(),
    ),

    //INFO PRA TENDER
    GetPage(
      name: Routes.SEARCH_INFO_PRA_TENDER,
      page: () => SearchInfoPraTenderView(),
      binding: SearchInfoPraTenderBinding(),
    ),
    GetPage(
      name: Routes.BROWSE_INFO_PRA_TENDER,
      page: () => BrowseInfoPraTenderView(),
      binding: BrowseInfoPraTenderBinding(),
    ),
    //INFO PRA TENDER
    //PROSES TENDER
    GetPage(
      name: Routes.SEARCH_PROSES_TENDER,
      page: () => SearchProsesTenderView(),
      binding: SearchProsesTenderBinding(),
    ),
    //PROSES TENDER
    //PEMENANG TENDER
    GetPage(
      name: Routes.SEARCH_PEMENANG_TENDER,
      page: () => SearchPemenangTenderView(),
      binding: SearchPemenangTenderBinding(),
    ),
    //PEMENANG TENDER
    GetPage(
      name: Routes.SELECT_RUTE_TENDER,
      page: () => SelectRuteTenderView(),
      binding: SelectRuteTenderBinding(),
    ),
    GetPage(
      name: Routes.SELECT_TRANSPORTER_MITRA_TENDER,
      page: () => SelectTransporterMitraTenderView(),
      binding: SelectTransporterMitraTenderBinding(),
    ),
    GetPage(
      name: Routes.LIST_DIUMUMKAN_KEPADA_TENDER,
      page: () => ListDiumumkanKepadaTenderView(),
      binding: ListDiumumkanKepadaTenderBinding(),
    ),
    GetPage(
      name: Routes.LIST_INVITED_TRANSPORTER_TENDER,
      page: () => ListInvitedTransporterTenderView(),
      binding: ListInvitedTransporterTenderBinding(),
    ),

    GetPage(
      name: Routes.LIST_CITY_FILTER_ARK,
      page: () => ListCityFilterArkView(),
      binding: ListCityFilterArkBinding(),
    ),
    GetPage(
      name: Routes.LIST_DESTINASI_FILTER_ARK,
      page: () => ListDestinasiFilterArkView(),
      binding: ListDestinasiFilterArkBinding(),
    ),

    //FIRST TIME PAGE
    GetPage(
      name: Routes.SELAMAT_DATANG,
      page: () => SelamatDatangView(),
      binding: SelamatDatangBinding(),
    ),
    //FIRST TIME PAGE

    //VIDEO
    GetPage(
      name: Routes.LIHAT_VIDEO,
      page: () => LihatVideoView(),
      binding: LihatVideoBinding(),
    ),
    //VIDEO
    //DOKUMEN PERSYARATAN
    GetPage(
      name: Routes.LIHAT_DOKUMEN_PERSYARATAN,
      page: () => LihatDokumenPersyaratanView(),
      binding: LihatDokumenPersyaratanBinding(),
    ),
    //DOKUMEN PERSYARATAN
    //MANAJEMEN
    GetPage(
      name: Routes.MANAJEMEN_ROLE,
      page: () => ManajemenRoleView(),
      binding: ManajemenRoleBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_MANAJEMEN_ROLE,
      page: () => SearchManajemenRoleView(),
      binding: SearchManajemenRoleBinding(),
    ),
    GetPage(
      name: Routes.CREATE_MANAJEMEN_ROLE,
      page: () => CreateManajemenRoleView(),
      binding: CreateManajemenRoleBinding(),
    ),
    GetPage(
      name: Routes.EDIT_MANAJEMEN_ROLE,
      page: () => EditManajemenRoleView(),
      binding: EditManajemenRoleBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_MANAJEMEN_ROLE,
      page: () => DetailManajemenRoleView(),
      binding: DetailManajemenRoleBinding(),
    ),
    GetPage(
      name: Routes.MANAJEMEN_HAK_AKSES,
      page: () => ManajemenHakAksesView(),
      binding: ManajemenHakAksesBinding(),
    ),
    GetPage(
      name: Routes.MANAJEMEN_USER,
      page: () => ManajemenUserView(),
      binding: ManajemenUserBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_MANAJEMEN_USER,
      page: () => SearchManajemenUserView(),
      binding: SearchManajemenUserBinding(),
    ),
    GetPage(
      name: Routes.CREATE_MANAJEMEN_USER,
      page: () => CreateManajemenUserView(),
      binding: CreateManajemenUserBinding(),
    ),
    GetPage(
      name: Routes.MANAJEMEN_USER_BAGI_PERAN,
      page: () => ManajemenUserBagiPeranView(),
      binding: ManajemenUserBagiPeranBinding(),
    ),
    GetPage(
      name: Routes.CREATE_PASSWORD_SUBUSER,
      page: () => CreatePasswordSubUserView(),
      binding: CreatePasswordSubUserBinding(),
    ),
    GetPage(
      name: Routes.OTHERSIDE,
      page: () => OtherSideTransView(),
      binding: OtherSideTransBinding(),
    ),

    //MANAJEMEN
    GetPage(
      name: Routes.AFTER_LOGIN_SUBUSER,
      page: () => AfterLoginSubUserView(),
      binding: AfterLoginSubUserBinding(),
    ),

    //cari harga transport
    GetPage(
      name: Routes.KETENTUAN_HARGA_TRANSPORT,
      page: () => KetentuanHargaTransportView(),
      binding: KetentuanHargaTransportBinding(),
    ),
    GetPage(
      name: Routes.CARI_HARGA_TRANSPORT,
      page: () => CariHargaTransportView(),
      binding: CariHargaTransportBinding(),
    ),
    GetPage(
      name: Routes.HASIL_CARI_HARGA_TRANSPORT,
      page: () => HasilCariHargaTransportView(),
      binding: HasilCariHargaTransportBinding(),
    ),
    GetPage(
      name: Routes.CREATE_NOTIFICATION_HARGA,
      page: () => CreateNotificationHargaView(),
      binding: CreateNotificationHargaBinding(),
    ),
    GetPage(
      name: Routes.EDIT_NOTIFICATION_HARGA,
      page: () => EditNotificationHargaView(),
      binding: EditNotificationHargaBinding(),
    ),
    GetPage(
      name: Routes.SELECT_CITY_LOCATION,
      page: () => SelectCityLocationView(),
      binding: SelectCityLocationBinding(),
    ),
    GetPage(
      name: Routes.SELECT_DIUMUMKAN_KEPADA,
      page: () => SelectDiumumkanKepadaView(),
      binding: SelectDiumumkanKepadaBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_LOCATION_ADDRESS,
      page: () => SearchLocationAddressView(),
      binding: SearchLocationAddressBinding(),
    ),
    GetPage(
      name: Routes.OTP_PHONE_ARK,
      page: () => OtpPhoneARKView(),
      binding: OtpPhoneARKBinding(),
    ),
    GetPage(
      name: Routes.SUCCESS_REGISTER_ARK,
      page: () => SuccessRegisterARKView(),
      binding: SuccessRegisterARKBinding(),
    ),
    GetPage(
      name: Routes.SEARCH_BAGI_PERAN_SUB_USER,
      page: () => SearchBagiPeranSubUserView(),
      binding: SearchBagiPeranSubUserBinding(),
    ),

    //transport market
    GetPage(
      name: Routes.TRANSPORT_MARKET,
      page: () => TransportMarketView(),
      binding: TransportMarketBinding(),
    ),

    GetPage(
      name: Routes.LIST_LOCATION_FILTER_ARK,
      page: () => ListLocationFilterArkView(),
      binding: ListLocationFilterArkBinding(),
    ),
    GetPage(
      name: Routes.LIST_HEAD_CARRIER_TRUCK,
      page: () => ListHeadCarrierView(),
      binding: ListHeadCarrierBinding(),
    ),
    GetPage(
      name: Routes.LIST_TRANSPORTER_NOTIF,
      page: () => ListTransporterNotifView(),
      binding: ListTransporterNotifBinding(),
    ),

    //////////
    ///ARK>///
    //////////

    /////////
    ///ZO<///
    /////////

    GetPage(
      name: Routes.ZO_HOME_TRANSPORT_MARKET,
      page: () => ZoHomeTransportMarketView(),
      binding: ZoHomeTransportMarketBinding(),
    ),
    GetPage(
      name: Routes.ZO_LELANG_MUATAN,
      page: () => ZoLelangMuatanView(),
      binding: ZoLelangMuatanBinding(),
    ),
    GetPage(
      name: Routes.ZO_LIST_NOTIFIKASI_SHIPPER,
      page: () => ZoListNotifikasiShipperView(),
      binding: ZoListNotifikasiShipperBinding(),
    ),
    GetPage(
      name: Routes.ZO_FILTER_LELANG_MUATAN,
      page: () => ZoFilterLelangMuatanView(),
      binding: ZoFilterLelangMuatanBinding(),
    ),
    GetPage(
      name: Routes.ZO_FILTER_JENIS_TRUK_LELANG_MUATAN,
      page: () => ZoFilterJenisTrukLelangMuatanView(),
      binding: ZoFilterJenisTrukLelangMuatanBinding(),
    ),
    GetPage(
      name: Routes.ZO_BUAT_LELANG_MUATAN,
      page: () => ZoBuatLelangMuatanView(),
      binding: ZoBuatLelangMuatanBinding(),
    ),
    GetPage(
      name: Routes.ZO_SEARCH_LOKASI,
      page: () => ZoSearchLokasiView(),
      binding: ZoSearchLokasiBinding(),
    ),
    GetPage(
      name: Routes.ZO_FILTER_TRUCK_SATUAN,
      page: () => ZoFilterTruckSatuanView(),
      binding: ZoFilterTruckSatuanBinding(),
    ),
    GetPage(
      name: Routes.ZO_SEARCH_LELANG_MUATAN,
      page: () => ZoSearchLelangMuatanView(),
      binding: ZoSearchLelangMuatanBinding(),
    ),
    GetPage(
      name: Routes.ZO_LIST_MUATAN,
      page: () => ZoListMuatanView(),
      binding: ZoListMuatanBinding(),
    ),
    GetPage(
      name: Routes.ZO_DETAIL_LELANG_MUATAN,
      page: () => ZoDetailLelangMuatanView(),
      binding: ZoDetailLelangMuatanBinding(),
    ),
    GetPage(
      name: Routes.ZO_MAP_FULL_SCREEN,
      page: () => ZoMapFullScreenView(),
      binding: ZoMapFullScreenBinding(),
    ),
    GetPage(
      name: Routes.ZO_MAP_FULL_SCREEN_TAMBAH,
      page: () => ZoMapFullScreenTambahView(),
      binding: ZoMapFullScreenTambahBinding(),
    ),
    GetPage(
      name: Routes.ZO_MAP_SELECT_LOCATION,
      page: () => ZoMapSelectLocationView(),
      binding: ZoMapSelectLocationBinding(),
    ),
    GetPage(
      name: Routes.ZO_MAP_SELECT,
      page: () => ZoMapSelectView(),
      binding: ZoMapSelectBinding(),
    ),
    GetPage(
      name: Routes.ZO_PESERTA_LELANG,
      page: () => ZoPesertaLelangView(),
      binding: ZoPesertaLelangBinding(),
    ),
    GetPage(
      name: Routes.ZO_PESERTA_LELANG_SEARCH,
      page: () => ZoPesertaLelangSearchView(),
      binding: ZoPesertaLelangSearchBinding(),
    ),
    GetPage(
      name: Routes.ZO_PILIH_PEMENANG_LELANG,
      page: () => ZoPilihPemenangLelangView(),
      binding: ZoPilihPemenangLelangBinding(),
    ),
    GetPage(
      name: Routes.ZO_PEMENANG_LELANG + "/:bidId",
      page: () => ZoPemenangLelangView(),
      binding: ZoPemenangLelangBinding(),
    ),
    GetPage(
      name: Routes.ZO_PEMENANG_LELANG + "/:bidId/search",
      page: () => ZoPemenangLelangSearchView(),
      binding: ZoPemenangLelangBinding(),
    ),
    GetPage(
      name: Routes.ZO_BERI_RATING + "/:bidId/:transporterId",
      page: () => ZoBeriRatingView(),
      binding: ZoBeriRatingBinding(),
    ),
    GetPage(
      name: Routes.ZO_PILIH_PEMENANG_SEARCH,
      page: () => ZoPilihPemenangSearchView(),
      binding: ZoPilihPemenangSearchBinding(),
    ),
    GetPage(
      name: Routes.ZO_BUAT_HARGA_PROMO,
      page: () => ZoBuatHargaPromoView(),
      binding: ZoBuatHargaPromoBinding(),
    ),
    GetPage(
      name: Routes.ZO_LIST_HARGA_PROMO,
      page: () => ZoListHargaPromoView(),
      binding: ZoListHargaPromoBinding(),
    ),
    GetPage(
      name: Routes.ZO_PROMO_TRANSPORTER,
      page: () => ZoPromoTransporterView(),
      binding: ZoPromoTransporterBinding(),
    ),
    // GetPage(
    //   name: Routes.ZO_PROMO_TRANSPORTER_LATEST_SEARCH,
    //   page: () => ZoPromoTransporterLatestSearchView(),
    // ),
    GetPage(
      name: Routes.ZO_PROMO_TRANSPORTER_FILTER_LOCATION,
      page: () => ZoPromoTransporterFilterLocationView(),
      binding: ZoPromoTransporterFilterLocationBinding(),
    ),
    GetPage(
      name: Routes.ZO_PROMO_TRANSPORTER_FILTER_TRUCK,
      page: () => ZoPromoTransporterFilterTruckView(),
      binding: ZoPromoTransporterFilterTruckBinding(),
    ),
    GetPage(
      name: Routes.ZO_PROMO_TRANSPORTER_FILTER_TRANSPORTER,
      page: () => ZoPromoTransporterFilterTransporterView(),
      binding: ZoPromoTransporterFilterTransporterBinding(),
    ),
    GetPage(
      name: Routes.ZO_NOTIFIKASI_HARGA,
      page: () => ZoNotifikasiHargaView(),
      binding: ZoNotifikasiHargaBinding(),
    ),
    GetPage(
      name: Routes.ZO_NOTIFIKASI_HARGA_EDIT,
      page: () => ZoNotifikasiHargaEditView(),
      binding: ZoNotifikasiHargaEditBinding(),
    ),

    /////////
    ///ZO>///
    /////////
  ];
}
