--高速决斗技能-坠落升空
Duel.LoadScript("speed_duel_common.lua")
function c100730053.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730053.skill,c100730053.con,aux.Stringid(100730053,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730053.filter(c)
	return c:IsRace(RACE_FAIRY) and c:IsLevelBelow(4)
end
function c100730053.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetMZoneCount(tp)>0
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.IsExistingMatchingCard(c100730053.filter,tp,LOCATION_GRAVE,0,1,nil)
end
function c100730053.skill(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,1-tp,100730053)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100730053.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
	local tc=g:GetFirst()
	if not tc then return end
	local atk=tc:GetTextAttack()
	Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP_DEFENSE)
	Duel.Recover(tp,atk,REASON_EFFECT)
	e:Reset()
end