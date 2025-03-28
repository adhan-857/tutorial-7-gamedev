# Tutorial 7 - Basic 3D Game Mechanics & Level Design
## Ramadhan Andika Putra (2206081976) - GameDev A <br>

### Latihan Mandiri: Eksplorasi Mechanics 3D

Saya memilih untuk mengerjakan opsi *mechanics* yang kedua

#### *Sprinting & crouching*
> Saya mengimplementasikan *sprinting* dan *crouching* dengan mengatur *multiplier* kecepatan berdasarkan input pemain. Saat pemain menekan tombol gerak maju dua kali dalam rentang waktu tertentu *(double tap)*, saya mendeteksi input tersebut menggunakan `if Input.is_action_just_pressed("movement_forward"):` dan menghitung waktu antar tekan dengan `Time.get_ticks_msec()`. Jika waktunya kurang dari `double_tap_time`, maka variabel `is_sprinting` diaktifkan sehingga kecepatan pemain dikalikan dengan `sprint_multiplier` dan membuat pemain bergerak lebih cepat. <br>
<br>
Selain itu, saya juga menerapkan *crouching* dengan memeriksa apakah tombol `Shift` ditekan secara langsung melalui `Input.is_key_pressed(KEY_SHIFT)`. Jika tombol tersebut ditekan, variabel `is_crouching` diaktifkan dan kecepatan pemain dikalikan dengan `crouch_multiplier` yang lebih rendah, sehingga pergerakan menjadi lambat. Dengan cara ini, pemain bisa memilih antara kecepatan normal, *sprint* dengan kecepatan lebih tinggi, atau berjalan sambil jongkok dengan kecepatan yang lebih lambat sesuai input yang diberikan.