--高速决斗技能-宝石龙们！
Duel.LoadScript("speed_duel_common.lua")
function c100730248.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730248.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730248.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local g=Group.CreateGroup()
	if not Duel.IsExistingMatchingCard(c100730248.filter,tp,LOCATION_DECK+LOCATION_HAND,0,3,nil,g) then
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730248,0))
	else
		Duel.Hint(HINT_CARD,1-tp,100730248)
		local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,nil)
		local c=g:RandomSelect(tp,4,4,nil)
		Duel.SendtoDeck(c,nil,1,REASON_RULE)
		local d1=Duel.CreateToken(tp,38699854)
		Duel.SendtoDeck(d1,nil,0,REASON_RULE)
		local d2=Duel.CreateToken(tp,15981690)
		Duel.SendtoDeck(d2,nil,0,REASON_RULE)
		local c=Duel.CreateToken(tp,33508719)
		aux.SpeedDuelSendToHandWithExile(tp,c)
		local c=Duel.CreateToken(tp,59432181)
		aux.SpeedDuelSendToHandWithExile(tp,c)
		local c=Duel.CreateToken(tp,5405694)
		aux.SpeedDuelSendToHandWithExile(tp,c)
		local c=Duel.CreateToken(tp,38120068)
		aux.SpeedDuelSendToHandWithExile(tp,c)
	end
	e:Reset()
end
function c100730248.filter(c,g)
	if not c:IsCode(62397231,17658803,11091375,43096270) then return false end
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