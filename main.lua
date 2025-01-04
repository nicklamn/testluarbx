-- Create the ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create the main frame for the message box
local messageBox = Instance.new("Frame")
messageBox.Parent = screenGui
messageBox.Size = UDim2.new(0, 450, 0, 300)  -- Set the size to a 2:3 ratio (width: 450, height: 300)
messageBox.Position = UDim2.new(0.5, -225, 0.5, -150)  -- Center it on the screen (half of width: 225, half of height: 150)
messageBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Set background color to black

-- Create the gray top bar
local topBar = Instance.new("Frame")
topBar.Parent = messageBox
topBar.Size = UDim2.new(1, 0, 0, 40)  -- Make the bar span the width of the box
topBar.BackgroundColor3 = Color3.fromRGB(128, 128, 128)  -- Set gray color
topBar.Position = UDim2.new(0, 0, 0, 0)  -- Position at the top of the message box

-- Create the "X" button to close the message box
local closeButton = Instance.new("TextButton")
closeButton.Parent = messageBox  -- Parent the button to the message box directly
closeButton.Text = "X"
closeButton.Size = UDim2.new(0, 40, 0, 40)  -- Set the size of the button
closeButton.Position = UDim2.new(1, -40, 0, 0)  -- Position it in the top-right corner of the message box
closeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Set the background color of the button
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Set text color to white
closeButton.TextScaled = true  -- Scale text to fit the button
closeButton.BorderSizePixel = 0  -- Remove the border around the button

-- When the "X" button is clicked, destroy the message box
closeButton.MouseButton1Click:Connect(function()
    messageBox:Destroy()  -- Remove the message box
end)

-- Create the TextLabel (the actual message)
local textLabel = Instance.new("TextLabel")
textLabel.Parent = messageBox  -- Parent the label to the message box
textLabel.Text = "Welcome to my Script!\nThis works!\nCheck the Code!"
textLabel.Size = UDim2.new(1, 0, 1, -40)  -- Make it take the full size minus the top bar height (40px)
textLabel.Position = UDim2.new(0, 0, 0, 40)  -- Position the text below the top bar
textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Set background color to black (same as the message box)
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Set text color to white
textLabel.TextScaled = false  -- Disable automatic text scaling
textLabel.TextSize = 24  -- Set the text size to 8px (half of the original size)
textLabel.TextStrokeTransparency = 0.8  -- Add text stroke for visibility

-- Variables for drag functionality
local dragToggle = nil
local dragStart = nil
local startPos = nil

-- Function to start dragging
local function onDragStart(input)
    dragToggle = true
    dragStart = input.Position
    startPos = messageBox.Position
end

-- Function to drag the message box
local function onDrag(input)
    if dragToggle then
        local delta = input.Position - dragStart
        messageBox.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end

-- Function to stop dragging
local function onDragEnd()
    dragToggle = false
end

-- Connect drag events to the top bar
topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        onDragStart(input)
    end
end)

topBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        onDrag(input)
    end
end)

topBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        onDragEnd()
    end
end)
