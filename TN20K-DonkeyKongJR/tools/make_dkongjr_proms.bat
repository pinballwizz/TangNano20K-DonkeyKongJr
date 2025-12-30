copy /b djr1-c_5b_f-2.5b + djr1-c_5c_f-2.5c + djr1-c_5e_f-2.5e dkongjr_cpu.bin
make_vhdl_prom dkongjr_cpu.bin CPUROM.vhd

make_vhdl_prom djr1-v.3n ROM3N.vhd
make_vhdl_prom djr1-v.3p ROM3P.vhd

make_vhdl_prom djr1-v_7c.7c ROM7C.vhd
make_vhdl_prom djr1-v_7d.7d ROM7D.vhd
make_vhdl_prom djr1-v_7e.7e ROM7E.vhd
make_vhdl_prom djr1-v_7f.7f ROM7F.vhd

make_vhdl_prom djr1-c-2e.2e pal1_rom.vhd
make_vhdl_prom djr1-c-2f.2f pal2_rom.vhd
make_vhdl_prom djr1-v-2n.2n col_rom.vhd

make_vhdl_prom djr1-c_3h.3h snd_rom.vhd

pause