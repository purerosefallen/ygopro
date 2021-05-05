--高速决斗技能-真红眼融合
Duel.LoadScript("speed_duel_common.lua")
function c100730067.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730067.skill,c100730067.con,aux.Stringid(100730067,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730067.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetLP(tp)<=2400
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK,0,1,nil,6172122)
		and (Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_HAND,0,1,nil,0x3b)
		or (Duel.GetLP(tp)==2400 and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,74677422)))
end
function c100730067.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730067)
	local g=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_HAND,0,nil,0x3b)
	if Duel.GetLP(tp)==2400 then
		local g2=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_GRAVE,0,nil,74677422)
		g:Merge(g2)
	end
	local c=g:Select(tp,1,1,nil)
	if c then
		Duel.SendtoDeck(g,nil,REASON_RULE)
		local g3=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_DECK,0,nil,6172122)
		if #g3>0 then
			Duel.SendtoHand(g3:GetFirst())
		end
	end
	e:Reset()
end
