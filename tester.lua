repeat wait() until game:IsLoaded()

local autofarm_time = _G.time
local no_print = _G.print


-- // Notifier // --
-- // I wanted to hijack bloxburg's one but i got lazy :( // --
local function notify(title, msg, icon)
    game.StarterGui:SetCore("SendNotification",{
        Title = title;
        Text = msg;
        Icon = icon;
        Duration = 5;
        })
end


-- // Load Logic // --
if _G.loaded == true then
    notify("Already loaded!", "You already executed this script!", "nothing")
    return
end
_G.loaded = true


-- // Key System (Yes, I know you can remove this, but this helps support me! :) ) // --
loadstring(game:HttpGet('https://raw.githubusercontent.com/ZackDaQuack/blox-cash/main/keysystem.lua', true))()
repeat wait(1) until _G.keydone == true
notify("Sucess!", "Your key was sucessfully validated! Now go to the cashier!", "rbxassetid://15234955230")
_G.keydone = false


-- // Hijack gui // --
local stop_autofarm = false
local menu = game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Bar.SettingsMenu.Menu
menu.ImageColor3 = Color3.fromRGB(255, 40, 40)
menu.TextLabel.Text = "Stop Autofarm"
menu.Name = "duck"
local store = game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Bar.SettingsMenu.Store
store.ImageColor3 = Color3.fromRGB(255, 40, 40)
store.TextLabel.Text = "Infinite Yield"
store.Name = "duck2"
task.wait(1)
local menu_hyjaked = game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Bar.SettingsMenu.duck
local store_hyjaked = game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Bar.SettingsMenu.duck2
menu_hyjaked.MouseButton1Click:Connect(function()
    if stop_autofarm == false then
        stop_autofarm = true
        store_hyjaked.TextLabel.Text = "Store"
        store_hyjaked.Name = "Store"
        store_hyjaked.ImageColor3 = Color3.fromRGB(0, 170, 255)
        menu_hyjaked.ImageColor3 = Color3.fromRGB(0, 170, 255)
        menu_hyjaked.TextLabel.Text = "Done!"
        task.wait(.5)
        menu_hyjaked.TextLabel.Text = "Main Menu"
        menu_hyjaked.Name = "Menu"
    end
end)
store_hyjaked.MouseButton1Click:Connect(function()
    if stop_autofarm == false then
        -- // why not // --
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
end)


-- // Keep menu hijacked // --
game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Bar.Settings.MouseButton1Click:Connect(function()
    if stop_autofarm == false then
        task.wait(.1)
        menu_hyjaked.ImageColor3 = Color3.fromRGB(255, 40, 40)
        menu_hyjaked.TextLabel.Text = "Stop Autofarm"
        store_hyjaked.ImageColor3 = Color3.fromRGB(255, 40, 40)
        store_hyjaked.TextLabel.Text = "Infinite Yield"
    end
end)


-- // Varriables // --
local ingredients_path
repeat
    wait(1)
    local success, errorOrResult = pcall(function()
        ingredients_path = game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.CashierFrame.Background.InnerBackground.Pages.Burger.Ingredients
    end)
until ingredients_path
local drink_path = game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.CashierFrame.Background.InnerBackground.Pages.Drink
local side_path = game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.CashierFrame.Background.InnerBackground.Pages.Side
local tabs_path = game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.CashierFrame.Background.InnerBackground.Tabs
local time_started = os.time()


-- // Ingredient Varriables // --
local ingredients = {
    bottom_bun = ingredients_path["Bottom Bun [Raw]"].Button.AbsolutePosition,
    cheese = ingredients_path["Cheese [Chopped]"].Button.AbsolutePosition,
    lettuce = ingredients_path["Lettuce [Chopped]"].Button.AbsolutePosition,
    patty_left = ingredients_path["Meat Patty [Cooked]"].Button.AbsolutePosition,
    onion = ingredients_path["Onion [Chopped]"].Button.AbsolutePosition,
    patty_right = ingredients_path["Plantbased Patty [Cooked]"].Button.AbsolutePosition,
    tomato = ingredients_path["Tomato [Chopped]"].Button.AbsolutePosition,
    top_bun = ingredients_path["Top Bun [Raw]"].Button.AbsolutePosition,

    d_s = drink_path:FindFirstChild("Size").Small.AbsolutePosition,
    d_m = drink_path:FindFirstChild("Size").Medium.AbsolutePosition,
    d_l = drink_path:FindFirstChild("Size").Large.AbsolutePosition,
    soda = drink_path.Type["Fountain Drink"].AbsolutePosition,
    fruit_juice = drink_path.Type["FruityFruit Juice"].AbsolutePosition,
    milkshake = drink_path.Type["Vanilla Milkshake"].AbsolutePosition,

    s_s = side_path:FindFirstChild("Size").Small.AbsolutePosition,
    s_m = side_path:FindFirstChild("Size").Medium.AbsolutePosition,
    s_l = side_path:FindFirstChild("Size").Large.AbsolutePosition,
    fries = side_path.Type["Fries [Ready]"].AbsolutePosition,
    moz_sticks = side_path.Type["Mozarella Sticks [Ready]"].AbsolutePosition,
    onion_rings = side_path.Type["Onion Rings [Ready]"].AbsolutePosition,

    burger_tab = tabs_path["Burger"].AbsolutePosition,
    confirm = tabs_path["Confirm"].AbsolutePosition,
    drink_tab = tabs_path["Drink"].AbsolutePosition,
    side_tab = tabs_path["Side"].AbsolutePosition,
}


-- // Find the middle of the buttons // --
local width = ingredients_path["Tomato [Chopped]"].Button.AbsoluteSize.X / 2
local height = ingredients_path["Tomato [Chopped]"].Button.AbsoluteSize.Y / 2


-- // Update positions of the items // --
local function load_items()
    local succ, err = pcall(function()
        ingredients.bottom_bun = ingredients_path["Bottom Bun [Raw]"].Button.AbsolutePosition
        ingredients.cheese = ingredients_path["Cheese [Chopped]"].Button.AbsolutePosition
        ingredients.lettuce = ingredients_path["Lettuce [Chopped]"].Button.AbsolutePosition
        ingredients.patty_left = ingredients_path["Meat Patty [Cooked]"].Button.AbsolutePosition
        ingredients.onion = ingredients_path["Onion [Chopped]"].Button.AbsolutePosition
        ingredients.patty_right = ingredients_path["Plantbased Patty [Cooked]"].Button.AbsolutePosition
        ingredients.tomato = ingredients_path["Tomato [Chopped]"].Button.AbsolutePosition
        ingredients.top_bun = ingredients_path["Top Bun [Raw]"].Button.AbsolutePosition

        ingredients.d_s = drink_path:FindFirstChild("Size").Small.AbsolutePosition
        ingredients.d_m = drink_path:FindFirstChild("Size").Medium.AbsolutePosition
        ingredients.d_l = drink_path:FindFirstChild("Size").Large.AbsolutePosition
        ingredients.soda = drink_path.Type["Fountain Drink"].AbsolutePosition
        ingredients.fruit_juice = drink_path.Type["FruityFruit Juice"].AbsolutePosition
        ingredients.milkshake = drink_path.Type["Vanilla Milkshake"].AbsolutePosition

        ingredients.s_s = side_path:FindFirstChild("Size").Small.AbsolutePosition
        ingredients.s_m = side_path:FindFirstChild("Size").Medium.AbsolutePosition
        ingredients.s_l = side_path:FindFirstChild("Size").Large.AbsolutePosition
        ingredients.fries = side_path.Type["Fries [Ready]"].AbsolutePosition
        ingredients.moz_sticks = side_path.Type["Mozarella Sticks [Ready]"].AbsolutePosition
        ingredients.onion_rings = side_path.Type["Onion Rings [Ready]"].AbsolutePosition

        ingredients.burger_tab = tabs_path["Burger"].AbsolutePosition
        ingredients.confirm = tabs_path["Confirm"].AbsolutePosition
        ingredients.drink_tab = tabs_path["Drink"].AbsolutePosition
        ingredients.side_tab = tabs_path["Side"].AbsolutePosition
    end)
    if not succ then
        notify("Script Error!", "An error has occurred when trying to update item positions.", "rbxassetid://4519042263")
    end
end


-- // Finds the object name from roblox asset id // --
local image_to_object = {
    ["rbxassetid://14358866788"] = "patty_left",
    ["rbxassetid://14358886220"] = "patty_right",
    ["rbxassetid://14358865402"] = "lettuce",
    ["rbxassetid://14358884748"] = "tomato",
    ["rbxassetid://14358880695"] = "cheese",
    ["rbxassetid://14467423053"] = "fries",
    ["rbxassetid://14467425084"] = "soda",
    ["rbxassetid://14467509651"] = "moz_sticks",
    ["rbxassetid://14358878251"] = "onion",
    ["rbxassetid://14467511580"] = "onion_rings",
    ["rbxassetid://9555980177"] = "fruit_juice",
    ["rbxassetid://1588110682"] = "milkshake"
}


-- // Custom print function lol // --
local function duck_print(msg)
    if no_print == false then
        print(msg)
    end
end


-- // Click Function // --
function click(object)
    if ingredients[object] then
        local Pos1 = ingredients[object].X + width
        local Pos2 = ingredients[object].Y + (height * 2)
        local wait_time = 0.15 + math.random() * 0.4
        if Pos1 and Pos2 then
            duck_print("Clicking "..object.." at "..tostring(Pos1).." "..tostring(Pos2)..". Wait time: "..tostring(wait_time))
            task.wait(wait_time)
            local vim = game:GetService('VirtualInputManager')
            vim:SendMouseButtonEvent(Pos1, Pos2, 0, true, game, 0)
            wait()
            vim:SendMouseButtonEvent(Pos1, Pos2, 0, false, game, 0)
        else
            warn("Invalid positions for "..object)
        end
    else
        warn("Object not found in the ingredients table. ("..tostring(object)..")")
    end
end


-- // Find Customer Order // --
local function find_order()
    local order = {}
    local amount = {}
    local order_place
    for i, character in workspace._game.SpawnedCharacters:GetChildren() do
        if character.Name == "BloxBurgersCustomer" then
            if character.Head:FindFirstChild("ChatBubble") then
                for i, head in character.Head.ChatBubble.Body.IconFrame:GetChildren() do
                    order_place = head.Name
                    if head:IsA("Frame") then
                        for i, frame in head:GetChildren() do
                            if frame:IsA("ImageLabel") then
                                if frame.Image ~= "rbxassetid://2037427845" then
                                    table.insert(order, frame.Image)
                                    local success, value = pcall(function()
                                        table.insert(amount, frame.Amount.TextLabel.Text)
                                    end)
                                    if not success then
                                        table.insert(amount, frame:FindFirstChild("Size").TextLabel.Text)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if #order > 0 then
        return order, amount, order_place
    else
        return false
    end
end


-- // Click Appropiate Size // --
local function click_size(size, type)
    local prefix = (type:lower() == "s") and "s_" or "d_"
    click(prefix .. size:lower())
end


-- // Main Loop // --
local burger_done = false
local fries_done = false
local soda_done = false
while stop_autofarm == false do
    task.wait(.25)
    local order, amount, order_place = find_order()
    if order ~= false then
        if order_place == "1" then
            if burger_done == false then
                load_items()
                click("bottom_bun")
                for i, v in order do
                    for i = 1, amount[i]:match("%d+") do
                        click(image_to_object[v])
                    end
                end
                click("top_bun")
                burger_done = true
            end
        end
        if order_place == "2" then
            if fries_done == false then
                local captured_order = order[1]
                local captured_amount = amount[1]
                click("side_tab")
                task.wait(1.3)
                load_items()
                click(image_to_object[captured_order])
                click_size(captured_amount, "s")
                fries_done = true
            end
        end
        if order_place == "3" then
            if soda_done == false then
                local captured_order = order[1]
                local captured_amount = amount[1]
                click("drink_tab")
                task.wait(1.3)
                load_items()
                click(image_to_object[captured_order])
                click_size(captured_amount, "d")
                soda_done = true
            end
        end
        order, amount, order_place = find_order()
        if os.time() - time_started > (autofarm_time * 3600) then
            return game.Players.LocalPlayer:Kick("The autofarm automatically ended after "..tostring(autofarm_time).." hours! Hope you enjoyed!")
        end
    else
        if burger_done == true then
            click("confirm")
            burger_done = false
            fries_done = false
            soda_done = false
            task.wait(3.4)
        end
    end
end

notify("Stopped", "The autofarm has stopped. Hope you enjoyed!", "rbxassetid://4485364382")
_G.loaded = false

--[[

Things I would like to add:
 
    - Automatically go to the cashier
    - Auto moods
    - Clean up the code a little

You can help and contribute :D

Made by ZackDaQuack!

--]]
