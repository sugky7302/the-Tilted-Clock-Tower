return {
    name = '測試',
    time = 2,
    mode = 0,
    model = '',
    model_point = '',
    global = false,
    max = 1,
    keep_after_death = false,
    on_add = function()
        print('add')
    end,
    on_remove = function()
        print('remove')
    end,
    on_finish = function()
        print('finish')
    end,
    on_cover = function()
        print('cover')
    end,
    on_pulse = function()
        print('pulse')
    end
}
