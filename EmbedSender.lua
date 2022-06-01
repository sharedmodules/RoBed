local MessageEmbed = {};
MessageEmbed.__index = MessageEmbed

function MessageEmbed.new()
	return setmetatable({
		Settings = {Color = '0xFFFFF', Title = 'nothing', Description = 'Nothing', Fields = {}},
		Embed = {}
	}, MessageEmbed)
end

function MessageEmbed:MakeEmbed()
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

function MessageEmbed:SetColor(Color)
	self.Settings.Color = Color
	return self
end

function MessageEmbed:SetDescription(Description)
	self.Settings.Description = Description
	return self
end

function MessageEmbed:SetTitle(Title)
	self.Settings.Title = Title
	return self
end

function MessageEmbed:AddFields(Name, Value, InLine)
	local FieldData = {['name'] = Name, ['value'] = Value, ['inline'] = InLine}
	table.insert(self.Settings.Fields, FieldData)
	return self
end

function MessageEmbed:Finish(WebHookURL)
	syn.request({
		Url = WebHookURL,
		Method = 'POST',
		Headers = {
			['Content-Type'] = 'application/json'
		},
		Body = game:GetService('HttpService'):JSONEncode(self.Embed)
	})
end

return MessageEmbed
