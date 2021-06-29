--高速决斗技能-仪式大师
Duel.LoadScript("speed_duel_common.lua")
function c100730118.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730118.skill,c100730118.con,aux.Stringid(100730118,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730118.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(c100730118.filter,tp,LOCATION_DECK,0,1,nil)
end
function c100730118.filter(c)
	return c:IsType(TYPE_RITUAL) and c:IsAbleToHand()
end
function c100730118.filter1(c)
	return c:IsType(TYPE_RITUAL) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c100730118.filter2(c)
	return bit.band(c:GetType(),0x82)==0x82 and c:IsAbleToHand()
end
function c100730118.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730118)
	local g1=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
	local c=g1:Select(tp,1,1,nil)
	Duel.SendtoDeck(c,nil,1,REASON_RULE)
	local g=Duel.GetMatchingGroup(c100730118.filter1,tp,LOCATION_DECK,0,1,nil)
	local g4=Duel.GetMatchingGroup(c100730118.filter2,tp,LOCATION_DECK,0,1,nil)
	local op=Duel.SelectOption(tp,aux.Stringid(100730118,1),aux.Stringid(100730118,2))
	if op==0 and g:GetCount()~=0 then
		local g2=g:RandomSelect(tp,1)
		Duel.SendtoHand(g2,tp,REASON_RULE)
	elseif op==1 and g4:GetCount()~=0 then
		local g3=g4:RandomSelect(tp,1)
		Duel.SendtoHand(g3,tp,REASON_RULE)
	else Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730118,3))
	end
end