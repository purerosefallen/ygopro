--高速决斗技能-僵尸之主
Duel.LoadScript("speed_duel_common.lua")
function c100730106.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730106.skill,c100730106.con,aux.Stringid(100730106,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730106.filter(c)
	return c:IsRace(RACE_ZOMBIE) and c:IsLevelBelow(4)
end
function c100730106.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetMZoneCount(tp)>0
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_HAND,0,1,nil,TYPE_MONSTER)
		and Duel.IsExistingMatchingCard(c100730106.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil)
end
function c100730106.skill(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,1-tp,100730106)
	local g1=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_HAND,0,nil,TYPE_MONSTER)
	local c=g1:Select(tp,1,1,nil)
	if not c then return end
	Duel.SendtoGrave(c,nil,REASON_RULE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100730106.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
	local tc=g:GetFirst()
	if not tc then return end
	Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
	e:Reset()
end