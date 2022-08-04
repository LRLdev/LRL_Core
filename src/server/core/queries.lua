queries = {}
queries = {
    ['bahamas'] = {
        ['get_identity'] = 'SELECT * FROM summerz_characters WHERE id = ?',
        ['get_fines'] = 'SELECT fines AS multas FROM summerz_characters WHERE id = @id',
        ['set_fines'] = 'UPDATE summerz_characters SET fines = fines + @fines WHERE id = @id',
        ['add_prison'] = 'UPDATE summerz_characters SET prison = @prison WHERE id = @user_id',
        ['add_user_money'] = 'UPDATE summerz_characters SET bank = bank + @bank WHERE id = @id',
        ['del_user_money'] = 'UPDATE summerz_characters SET bank = bank - @bank WHERE id = @id',
        ['get_user_money'] = 'SELECT bank FROM summerz_characters WHERE id = @id',
        ['get_user_datatable'] = 'SELECT dvalue FROM summerz_playerdata WHERE user_id = @user_id AND dkey = "Datatable"',
        ['get_user_data'] = 'SELECT dvalue FROM summerz_playerdata WHERE user_id = @user_id AND dkey = @key',
        ['set_user_data'] = 'REPLACE INTO summerz_playerdata(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)',
        ['get_server_data'] = 'SELECT dvalue FROM summerz_entitydata WHERE dkey = @dkey',
        ['set_server_data'] = 'REPLACE INTO summerz_entitydata(dkey,dvalue) VALUES(@dkey,@value)'
    },
    ['vRP'] = {
        ['get_identity'] = 'SELECT * FROM vrp_user_identities WHERE user_id = ?',
        ['get_fines'] = 'SELECT dvalue as multas FROM vrp_user_data WHERE user_id = @id AND dkey = "vRP:multas"',
        ['set_fines'] = 'UPDATE vrp_user_data SET dvalue = dvalue + @fines WHERE user_id = @id AND dkey = "vRP:multas"',
        ['add_prison'] = 'REPLACE INTO vrp_user_data(user_id,dkey,dvalue) VALUES(@id,"vRP:prisao",@fines)',
        ['add_user_money'] = 'UPDATE vrp_user_moneys SET bank = bank + @bank WHERE user_id = @id',
        ['del_user_money'] = 'UPDATE vrp_user_moneys SET bank = bank - @bank WHERE user_id = @id',
        ['get_user_money'] = "SELECT bank FROM vrp_user_moneys WHERE user_id = @id",
        ['get_user_datatable'] = 'SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = "vRP:datatable"',
        ['get_user_data'] = 'SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @key',
        ['set_user_data'] = 'REPLACE INTO vrp_user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)',
        ['get_server_data'] = 'SELECT dvalue FROM vrp_srv_data WHERE dkey = @dkey',
        ['set_server_data'] = 'REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@dkey,@value)'
    },
    ['crv5'] = {
        ['get_identity'] = 'SELECT * FROM summerz_characters WHERE id = ?',
        ['get_fines'] = 'SELECT fines AS multas FROM summerz_characters WHERE id = @id',
        ['set_fines'] = 'UPDATE summerz_characters SET fines = fines + @fines WHERE id = @id',
        ['add_prison'] = 'UPDATE summerz_characters SET prison = @prison WHERE id = @user_id',
        ['add_user_money'] = 'UPDATE summerz_bank SET value = value + @bank WHERE user_id = @id AND mode = "Private" AND owner = 1',
        ['del_user_money'] = 'UPDATE summerz_bank SET value = value - @bank WHERE user_id = @id AND mode = "Private" AND owner = 1',
        ['get_user_money'] = 'SELECT bank FROM summerz_characters WHERE id = @id',
        ['get_user_datatable'] = 'SELECT dvalue FROM summerz_playerdata WHERE user_id = @user_id AND dkey = "Datatable"',
        ['get_user_data'] = 'SELECT dvalue FROM summerz_playerdata WHERE user_id = @user_id AND dkey = @key',
        ['set_user_data'] = 'REPLACE INTO summerz_playerdata(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)',
        ['get_server_data'] = 'SELECT dvalue FROM summerz_entitydata WHERE dkey = @dkey',
        ['set_server_data'] = 'REPLACE INTO summerz_entitydata(dkey,dvalue) VALUES(@dkey,@value)'
    },
}