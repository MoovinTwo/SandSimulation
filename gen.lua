

gridBuilder = {}
gridBuilder.__index = Generator

gfx = love.graphics
mouseX, mouseY = love.mouse.getPosition()
screenW, screenH = love.graphics.getDimensions()
function gridBuilder:init(gridW,gridH)

    self.gridW = gridW
    self.gridH = gridH

    self.cellW = screenW/self.gridW
    self.cellH = screenH/self.gridH

    self.cells = {}

    for i = 1,self.gridW do
        table.insert(self.cells, {} )
        for j = 1,self.gridH do
            table.insert(self.cells[i], {"air", "line"} )
        end
    end

end

function gridBuilder:draw()

    for i = 1,self.gridW do
        for j = 1,self.gridH do
            local curCell = self.cells[i][j]
            if self.cells[i][j][1] ~= "air" then
                gfx.setColor(love.math.colorFromBytes(self.cells[i][j][3]))
                gfx.rectangle(curCell[2], self.cellW*(i-1), self.cellH*(j-1), self.cellW, self.cellH)
            end
        end
    end
end

function gridBuilder:update()
    mouseX, mouseY = love.mouse.getPosition()
    local gX = math.floor(mouseX/self.cellW) + 1
    local gY = math.floor(mouseY/self.cellH) + 1

    for i = 1,self.gridW do
        for j = 1,self.gridH do
            local curCell = self.cells[i][j]
            if j == self.gridH or j == 1 or i == 1 or i == self.gridW then
                self.cells[i][j] = {"rock", "line", {255, 255, 255}}
            end
            if self.cells[i][j][1] == "sand" then
                if self.cells[i][j+1] ~= nil then
                    if self.cells[i][j+1][1] == "air" then
                        self.cells[i][j+1] = {"sand", "fill", self.cells[i][j][3]}
                        self.cells[i][j] = {"air", "line", {}}
                    else
                        if self.cells[i+1][j+1] ~= nil then
                            if self.cells[i+1][j+1] ~= nil then
                                local rand = math.random(1,2)
                                if rand == 1 then
                                    if self.cells[i+1][j+1] ~= nil then
                                        if self.cells[i+1][j+1][1] == "air" then
                                            self.cells[i+1][j+1] = {"sand", "fill", self.cells[i][j][3]}
                                            self.cells[i][j] = {"air", "line", {}}
                                        end
                                    end
                                elseif rand == 2 then
                                    if self.cells[i-1][j+1] ~= nil then
                                        if self.cells[i-1][j+1][1] == "air" then
                                            self.cells[i-1][j+1] = {"sand", "fill", self.cells[i][j][3]}
                                            self.cells[i][j] = {"air", "line", {}}
                                        end
                                    end
                                end
                            else
                                if self.cells[i+1][j+1] ~= nil then
                                    if self.cells[i+1][j+1][1] == "air" then
                                        self.cells[i+1][j+1] = {"sand", "fill", self.cells[i][j][3]}
                                        self.cells[i][j] = {"air", "line", {}}
                                    end
                                end
                            end
                        elseif self.cells[i-1][j+1] ~= nil then
                            if self.cells[i-1][j+1] ~= nil then
                                if self.cells[i-1][j+1][1] == "air" then
                                    self.cells[i-1][j+1] = {"sand", "fill", self.cells[i][j][3]}
                                    self.cells[i][j] = {"air", "line", {}}
                                end
                            end
                        end
                    end
                end
            end
            local sandColors = {{203, 189, 147},{250, 232, 180},{128, 119, 92},{87, 74, 36}}
            if i == gX then
                if j == gY then
                    if love.mouse.isDown(1) then
                        self.cells[i][j] = {"sand", "fill", sandColors[math.random(1,4)]}
                    end
                end
            end
        end
    end
end

