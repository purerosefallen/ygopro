--高速决斗技能-难以接受的结果
Duel.LoadScript("speed_duel_common.lua")
function c100730212.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730212.skill,c100730212.con,aux.Stringid(100730212,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730212.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730212.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,4072687)
end
function c100730212.skill(e,tp)
	Duel.Hint(HINT_CARD,1-tp,100730212)
	local g=Duel.GetMatchingGroup(c100730212.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	while tc do
		local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,4072687)
		if g2:GetCount()==0 then return end
		local c=g2:GetFirst()
		if not c then return end
		Duel.SendtoHand(c,tp,REASON_RULE)
		tc=g:GetNext()
	end
end
function c100730212.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsSetCard(0x12e)
end