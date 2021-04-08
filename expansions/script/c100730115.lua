--高速决斗技能-太阳和月亮
Duel.LoadScript("speed_duel_common.lua")
function c100730115.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730115.skill,c100730115.con,aux.Stringid(100730105,0))
	aux.SpeedDuelMoveCardToDeckCommon(39823987,c)
	aux.SpeedDuelMoveCardToDeckCommon(66818682,c)
	aux.SpeedDuelMoveCardToDeckCommon(41181774,c)
	aux.SpeedDuelMoveCardToDeckCommon(37910722,c)
	aux.SpeedDuelMoveCardToDeckCommon(25472513,c)
	aux.SpeedDuelMoveCardToDeckCommon(1686814,c)
	aux.SpeedDuelMoveCardToDeckCommon(90884403,c)
	aux.SpeedDuelMoveCardToDeckCommon(60025883,c)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730115.Isyubel(c)
	return (c:IsCode(39823987) and c:IsFaceup())
		or (c:IsCode(66818682) and c:IsFaceup())
end
function c100730115.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730115.Isyubel,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetMZoneCount(tp)>-1
		and Duel.IsPlayerCanSpecialSummon(tp)
end
function c100730115.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.SelectMatchingCard(tp,c100730115.Isyubel,tp,LOCATION_MZONE,0,1,1,nil)
	if not g then return end
	local tc=g:GetFirst()
	if tc:IsCode(66818682) then code=39823987 end
	if tc:IsCode(39823987) then code=66818682 end
	Duel.SendtoGrave(tc,REASON_RULE)
	Duel.Hint(HINT_CARD,1-tp,100730115)
	local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_EXTRA+LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,code)
	if g1:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local nc=g1:GetFirst()
		Duel.SpecialSummon(nc,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)
		nc:CompleteProcedure()
	end
end