--高速决斗技能-我的名字叫于贝尔
Duel.LoadScript("speed_duel_common.lua")
function c100730080.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730080.skill,c100730080.con,aux.Stringid(100730080,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730080.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,1,nil,4779091,31764700)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,78371393)
end
function c100730080.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,nil,4779091,31764700)
	local c=g:Select(tp,1,1,nil)
	if c then
		Duel.Hint(HINT_CARD,1-tp,100730080)
		Duel.SendtoDeck(g,1-tp,0,REASON_RULE)
		local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,78371393)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_RULE)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end