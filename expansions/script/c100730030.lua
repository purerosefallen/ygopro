--高速决斗技能-魔法专家
Duel.LoadScript("speed_duel_common.lua")
function c100730030.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c100730030.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730030.filter(c,g)
	if not c:IsType(TYPE_SPELL) then return false end
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
function c100730030.skill(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	if not Duel.IsExistingMatchingCard(c100730030.filter,tp,LOCATION_DECK+LOCATION_HAND,0,4,nil,g) then
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730030,0))
		e:Reset()
		return
	end
	tp=e:GetLabelObject():GetOwner()
	if not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_HAND,0,1,nil,TYPE_SPELL) then
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_HAND,0,nil)
		aux.SpeedDuelSendToDeckWithExile(tp,g)
		local g2=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_DECK,0,nil)
		g2=g2:RandomSelect(tp,count)
		aux.SpeedDuelSendToHandWithExile(tp,g2)
	end
	e:Reset()
end