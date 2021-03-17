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
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730115.Isyubel(c)
	return (c:IsOriginalCodeRule(39823987) and c:IsFaceup())
		or (c:IsOriginalCodeRule(66818682) and c:IsFaceup())
end
function c100730115.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730115.Isyubel,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetMZoneCount(tp)>-1
end
function c100730115.SequenceToZone(seq)
	return 1 << seq
end
function c100730115.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.SelectMatchingCard(tp,c100730115.Isyubel,tp,LOCATION_MZONE,0,1,1,nil)
	if not g then return end
	local tc=g:GetFirst()
	local pos=tc:GetPosition()
	local seq=tc:GetSequence()
	if tc:IsOriginalCodeRule(66818682) then code=39823987 end
	if tc:IsOriginalCodeRule(39823987) then code=66818682 end
	Duel.SendtoGrave(tc,REASON_RULE)
	local nc=Duel.CreateToken(tp,code)
	Duel.MoveToField(nc,tp,tp,LOCATION_MZONE,pos,true)
	Duel.MoveSequence(nc,seq)
end
function c100730115.DisableMonsterZone(e,tp)
	return 0x1f-aux.SequenceToZone(tc:GetSequence())
end
