local RoBed = {};
RoBed.__index = RoBed

function RoBed.new()
	return setmetatable({
		Settings = {Color = '0xFFFFF', Title = 'nothing', Description = 'Nothing', Fields = nil},
		Embed = {}
	}, RoBed)
end

function RoBed:MakeEmbed()
	local Settings = self.Settings
	self.Embed = {
		['embeds'] = {{
			['title'] = Settings.Title,
			['description'] = Settings.Description,
			['color'] = tonumber(Settings.Color),
			['type'] = 'rich',
			['fields'] = Settings.Fields
		}}
	}
end

function RoBed:SetColor(Color)
	self.Settings.Color = Color
end

function RoBed:SetDescription(Description)
	self.Settings.Description = Description
end

function RoBed:SetTitle(Title)
	self.Settings.Title = Title
end

function RoBed:AddField(Fields)
	self.Settings.Fields = {Fields}
end

function RoBed:SendTo(WebHookURL)
	syn.request({
		Url = WebHookURL,
		Method = 'POST',
		Headers = {
			['Content-Type'] = 'application/json'
		},
		Body = game:GetService('HttpService'):JSONEncode(self.Embed)
	})
end

return RoBed
