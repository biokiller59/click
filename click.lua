-- Автокликер без кнопки (активируется сразу)
local VirtualUser = game:GetService("VirtualUser")

-- Сообщение в консоль (F9), что скрипт запущен
print("Hack Script: Auto-Clicker Started")

-- Чтобы скрипт не "крашнул" игру, используем spawn функцию
task.spawn(function()
    while true do
        -- Имитируем нажатие и отпускание левой кнопки мыши
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new(851, 158), workspace.CurrentCamera.CFrame)
        
        -- Скорость кликов (0.05 = 20 кликов в секунду)
        task.wait(0.05) 
    end
end)
