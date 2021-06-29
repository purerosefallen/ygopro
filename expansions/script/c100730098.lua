--高速决斗技能-迷宫建造
Duel.LoadScript("speed_duel_common.lua")
function c100730098.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730098.skill,c100730098.con,aux.Stringid(100730098,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730098.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.GetMZoneCount(tp)>1
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,2,nil)
		and Duel.IsExistingMatchingCard(c100730098.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_EXTRA,0,1,nil,99551425)
end
function c100730098.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730098)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
	local c=g:Select(tp,2,2,nil)
	Duel.SendtoDeck(c,nil,2,REASON_RULE)
	local d=Duel.CreateToken(tp,67284908)
	Duel.MoveToField(d,tp,tp,LOCATION_MZONE,POS_FACEUP_DEFENSE,true)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectMatchingCard(tp,c100730098.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil)
	local eqc=g:GetFirst()
	Duel.Equip(tp,eqc,d)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_EXTRA,0,1,1,nil,99551425)
	local tc=g2:GetFirst()
	Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
	e:Reset()
end
function c100730098.filter(c)
	return c:IsCode(64389297) and not c:IsForbidden()
end