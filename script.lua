local P,S,U,C=game.Players,game:GetService("RunService"),game:GetService("UserInputService"),workspace.CurrentCamera
local LP=P.LocalPlayer local char=LP.Character or LP.CharacterAdded:Wait() local hum=char:WaitForChild("Humanoid")
local PG=LP:WaitForChild("PlayerGui") local SG=Instance.new("ScreenGui",PG) SG.Name="FERRAOHUBGUI"
local F=Instance.new("Frame",SG) F.Size=UDim2.new(0,220,0,220) F.Position=UDim2.new(0,20,0.5,-110) F.BackgroundColor3=Color3.fromRGB(30,30,30) F.BackgroundTransparency=0.1 F.BorderSizePixel=0
local UC=Instance.new("UICorner",F) UC.CornerRadius=UDim.new(0,12)
local L=Instance.new("TextLabel",F) L.Size=UDim2.new(1,-20,0,30) L.Position=UDim2.new(0,10,0,5) L.BackgroundTransparency=1 L.Font=Enum.Font.GothamBold L.TextSize=20 L.Text="FERRAO HUB" L.TextScaled=true
local h=0 S.RenderStepped:Connect(function() h=(h+0.5)%360 L.TextColor3=Color3.fromHSV(h/360,1,1) end)
local grid=Instance.new("UIGridLayout",F) grid.CellSize=UDim2.new(0,100,0,35) grid.CellPadding=UDim2.new(0,5,0,5) grid.FillDirectionMaxCells=2 grid.HorizontalAlignment=Enum.HorizontalAlignment.Center
local function Btn(n,c,f)local b=Instance.new("TextButton",F) b.Size=UDim2.new(0,100,0,35) b.BackgroundColor3=c b.TextColor3=Color3.fromRGB(255,255,255) b.Font=Enum.Font.GothamBold b.TextSize=14 b.TextWrapped=true b.Text=n;local bc=Instance.new("UICorner",b) bc.CornerRadius=UDim.new(0,6) b.MouseButton1Click:Connect(function() f(b) end) return b end
local Jump=false Btn("Pulo",Color3.fromRGB(0,170,255),function(b) Jump=not Jump b.Text=Jump and"Pulo Ativado!" or"Pulo" end) S.RenderStepped:Connect(function() if Jump then hum.Jump=true end end)
local Minimized=false
local Img=Instance.new("ImageButton",SG) Img.Size=UDim2.new(0,60,0,60) Img.Position=UDim2.new(0,20,0.5,-30) Img.BackgroundTransparency=1 Img.Image="rbxassetid://95745574515801" local ic=Instance.new("UICorner",Img) ic.CornerRadius=UDim.new(1,0) Img.Visible=false
local MinBtn=Btn("Minimizar",Color3.fromRGB(255,170,0),function() Minimized=not Minimized F.Visible=not Minimized Img.Visible=Minimized end)
local drag=false local offset
Img.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true offset=i.Position-Img.AbsolutePosition end end)
Img.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
U.InputChanged:Connect(function(i) if drag and i.UserInputType==Enum.UserInputType.MouseMovement then local np=i.Position-offset Img.Position=UDim2.new(0,np.X,0,np.Y) end end)
Img.MouseButton1Click:Connect(function() Minimized=false F.Visible=true Img.Visible=false end)
local ESP=false local objs={} local function makeESP(plr) if plr==LP then return end local b=Drawing.new("Square") b.Color=Color3.fromRGB(255,255,255) b.Thickness=2 b.Filled=false b.Visible=false local t=Drawing.new("Text") t.Color=Color3.fromRGB(255,255,255) t.Size=16 t.Center=true t.Outline=true t.Visible=false objs[plr]={Box=b,Name=t} plr.CharacterAdded:Connect(function() objs[plr].Box.Visible=false objs[plr].Name.Visible=false end) end
for _,p in pairs(P:GetPlayers()) do makeESP(p) end P.PlayerAdded:Connect(makeESP)
S.RenderStepped:Connect(function() if not ESP then for _,o in pairs(objs)do o.Box.Visible=false o.Name.Visible=false end return end for plr,obj in pairs(objs) do if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Head") then local hrp=plr.Character.HumanoidRootPart local h2=plr.Character:FindFirstChild("Humanoid") local head=plr.Character.Head local pos,onS=C:WorldToViewportPoint(hrp.Position) local hpos,hOn=C:WorldToViewportPoint(head.Position+Vector3.new(0,0.5,0)) if onS and hOn then local height=h2.HipHeight*8 local width=height/2 obj.Box.Size=Vector2.new(width,height) obj.Box.Position=Vector2.new(pos.X-width/2,pos.Y-height/2) obj.Box.Visible=true local dist=math.floor((LP.Character.HumanoidRootPart.Position-hrp.Position).Magnitude) obj.Name.Text=plr.Name.." ["..dist.."m]" obj.Name.Position=Vector2.new(hpos.X,hpos.Y-20) obj.Name.Visible=true else obj.Box.Visible=false obj.Name.Visible=false end else obj.Box.Visible=false obj.Name.Visible=false end end end)
Btn("ESP Caixa+Nome",Color3.fromRGB(0,255,0),function(b) ESP=not ESP b.Text=ESP and"ESP Ativado!"or"ESP Caixa+Nome" end)
-- GRUDAR BOLA BROOKHAVEN
local BallFollow=false Btn("Grudar Bola",Color3.fromRGB(255,0,255),function(b) BallFollow=not BallFollow b.Text=BallFollow and"Bola Seguindo!"or"Grudar Bola" end)
S.RenderStepped:Connect(function()
    if BallFollow then
        for _,v in pairs(workspace:GetChildren()) do
            if v:IsA("Part") and v.Name:lower():find("ball") then
                local target=v.Position
                local myPos=char:WaitForChild("HumanoidRootPart").Position
                v.Position=v.Position:Lerp(myPos,0.1)
            end
        end
    end
end)
