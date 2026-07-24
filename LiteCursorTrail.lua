local NUM_PARTICLES = 12
local TRAIL_SIZE = 12

local particles = {}
local posX = {}
local posY = {}

local frame = CreateFrame("Frame", nil, UIParent)
frame:SetAllPoints(UIParent)

local scale = UIParent:GetEffectiveScale()
local head = 1

for i = 1, NUM_PARTICLES do
    local tex = frame:CreateTexture(nil, "OVERLAY")

    tex:SetTexture("Interface\\Buttons\\WHITE8X8")
    tex:SetBlendMode("ADD")

    local size = TRAIL_SIZE - (i * 0.5)

    tex:SetSize(size, size)

    tex:SetVertexColor(
        0.2,
        0.8,
        1.0,
        1 - ((i - 1) / NUM_PARTICLES)
    )

    tex:Hide()

    particles[i] = tex
    posX[i] = 0
    posY[i] = 0
end

frame:SetScript("OnUpdate", function()
    local x, y = GetCursorPosition()

    x = x / scale
    y = y / scale

    head = head + 1
    if head > NUM_PARTICLES then
        head = 1
    end

    posX[head] = x
    posY[head] = y

    local idx = head - 3

if idx < 1 then
    idx = idx + NUM_PARTICLES
end

    for i = 1, NUM_PARTICLES do
        local p = particles[i]

        if p then
            p:ClearAllPoints()

            local delay = (i - 1) * 0.4
            local px = x + ((posX[idx] - x) * delay)
            local py = y + ((posY[idx] - y) * delay)

            p:SetPoint(
                "CENTER",
                UIParent,
                "BOTTOMLEFT",
                px + 130,
                py + 25
            )

            p:Show()
        end

        idx = idx - 1
        if idx < 1 then
            idx = NUM_PARTICLES
        end
    end
end)
