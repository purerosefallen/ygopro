--高速决斗技能-绝对命运之力！
Duel.LoadScript("speed_duel_common.lua")
function c100730210.initial_effect(c)
	if not c100730210.reg then
		c100730210.reg=true
		local toss_orig=Duel.TossCoin
		c100730210.used={}
		c100730210.used[0]=0
		c100730210.used[1]=0
		Duel.TossCoin =
		function (tp,count)
			local result={}
			while c100730210.used[tp]>0 and count>0 do
				table.insert(result,1)
				Duel.Hint(HINT_CARD,1-tp,100730210)
				Duel.Hint(HINT_OPSELECTED,tp,aux.Stringid(100730210,4))
				Duel.Hint(HINT_OPSELECTED,1-tp,aux.Stringid(100730210,4))
				count=count-1
				c100730210.used[tp]=c100730210.used[tp]-1
			end
			while count>0 do
				count=count-1
				table.insert(result,toss_orig(tp,1))
			end
			return table.unpack(result)
		end
	end
	aux.SpeedDuelBeforeDraw(c,c100730210.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730210.filter(c,g)
	if not c.toss_coin then return false end
	local tc=g:GetFirst()
	while tc do
		if c:GetOriginalCode()==tc:GetOriginalCode() then
			return false
		end
		tc=g:GetNext()
	end
	g:AddCard(c)
	return true
end
function c100730210.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Group.CreateGroup()
	if not Duel.IsExistingMatchingCard(c100730210.filter,tp,LOCATION_DECK+LOCATION_HAND,0,7,nil,g) then
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730210,0))
	else
		c100730210.used[tp]=3
	end
	e:Reset()
end