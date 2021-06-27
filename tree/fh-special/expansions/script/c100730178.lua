--高速决斗技能-再次并肩作战
Duel.LoadScript("speed_duel_common.lua")
function c100730178.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730178.skill,c100730178.con,aux.Stringid(100730178,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730178.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730178.IsYU,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.GetMZoneCount(tp)>0
end
function c100730178.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.SelectMatchingCard(tp,c100730178.IsYU,tp,LOCATION_GRAVE,0,1,1,nil)
	if not g then return end
	local tc=g:GetFirst()
	Duel.Remove(tc,POS_FACEUP,REASON_COST)
	local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_HAND,0,1,1,nil,89943723)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
		else Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730178,0))
	end
end
