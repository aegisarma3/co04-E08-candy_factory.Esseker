// Contrabandista

removeAllWeapons contrabandista;
removeAllItems contrabandista;
removeAllAssignedItems contrabandista;
removeUniform contrabandista;
removeVest contrabandista;
removeBackpack contrabandista;
removeHeadgear contrabandista;
removeGoggles contrabandista;

contrabandista forceAddUniform "TRYK_U_pad_j_blk";
for "_i" from 1 to 3 do {contrabandista addItemToUniform "9Rnd_45ACP_Mag";};
contrabandista addVest "V_Rangemaster_belt";
contrabandista addWeapon "hgun_ACPC2_F";
contrabandista linkItem "ItemMap";
contrabandista linkItem "ItemCompass";
contrabandista linkItem "ItemWatch";
contrabandista linkItem "ItemRadioAcreFlagged";
contrabandista setFace "GreekHead_A3_04";
contrabandista setSpeaker "ACE_NoVoice";




// GUarda Costas
removeAllWeapons guarda_costas;
removeAllItems guarda_costas;
removeAllAssignedItems guarda_costas;
removeUniform guarda_costas;
removeVest guarda_costas;
removeBackpack guarda_costas;
removeHeadgear guarda_costas;
removeGoggles guarda_costas;

guarda_costas forceAddUniform "TRYK_U_B_Denim_T_BG_BK";
guarda_costas addItemToUniform "9Rnd_45ACP_Mag";
guarda_costas addVest "TRYK_V_Sheriff_BA_TB";
for "_i" from 1 to 2 do {guarda_costas addItemToVest "SMA_20Rnd_762x51mm_M80A1_EPR";};


guarda_costas addWeapon "SMA_HK417afg";
guarda_costas addWeapon "hgun_ACPC2_F";


guarda_costas linkItem "ItemMap";
guarda_costas linkItem "ItemCompass";
guarda_costas linkItem "ItemWatch";
guarda_costas linkItem "ItemRadioAcreFlagged";


guarda_costas setFace "WhiteHead_03";
guarda_costas setSpeaker "ACE_NoVoice";
