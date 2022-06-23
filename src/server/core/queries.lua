queries = {}
queries = {
    ['bahamas'] = {
        ['get_identity'] = 'SELECT * FROM summerz_characters WHERE id = ?',
        ['get_fines'] = 'SELECT fines AS multas FROM summerz_characters WHERE id = @id',
        ['get_user_data'] = 'SELECT dvalue FROM summerz_playerdata WHERE user_id = @user_id AND dkey = @key',
        ['get_server_data'] = 'SELECT dvalue FROM summerz_entitydata WHERE dkey = @dkey',
        ['set_server_data'] = 'REPLACE INTO summerz_entitydata(dkey,dvalue) VALUES(@dkey,@value)'
    },
    ['vRP'] = {
        ['get_identity'] = 'SELECT * FROM vrp_user_identities WHERE user_id = ?',
        ['get_fines'] = 'SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = "vRP:multas"',
    }
}