local RoBed = {};
RoBed.__index = RoBed

function RoBed.new()
	return setmetatable({
		Settings = {Color = '0xFFFFF', Title = 'nothing', Description = 'Nothing', Fields = nil},
		Embed = {}
	}, RoBed)
end

function RoBed:MakeEmbed()
	self.Embed = {
		['embeds'] = {{
			['title'] = self.Settings.Title,
			['description'] = self.Settings.Description,
			['color'] = tonumber(self.Settings.Color),
			['type'] = 'rich',
			['fields'] = self.Settings.Fields
		}}
	}
end

function RoBed:SetColor(NewColor)
	self.Settings.Color = NewColor
end

function RoBed:SetTitle(NewTitle)
	self.Settings.Title = NewTitle
end

function RoBed:AddField(Information)
	self.Settings.Fields = {Information}
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
