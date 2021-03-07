--高速决斗技能-白龙变化
Duel.LoadScript("speed_duel_common.lua")
function c100730041.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730041.skill,c100730041.con,aux.Stringid(100730041,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730041.IsBlueEyes(c)
	return c:IsOriginalCodeRule(89631139) and c:IsFaceup()
end

function c100730041.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730041.IsBlueEyes,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetMZoneCount(tp)>-1
end
function c100730041.SequenceToZone(seq)
	return 1 << seq
end
function c100730041.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.SelectMatchingCard(tp,c100730041.IsBlueEyes,tp,LOCATION_MZONE,0,1,1,nil)
	if not g then return end
	local tc=g:GetFirst()
	local pos=tc:GetPosition()
	local seq=tc:GetSequence()

	Duel.Exile(tc,REASON_RULE)
	local newc=Duel.CreateToken(tp,38517737)
	Duel.MoveToField(newc,tp,tp,LOCATION_MZONE,pos,true)
	Duel.MoveSequence(newc,seq)
end
function c100730041.DisableMonsterZone(e,tp)
	return 0x1f-aux.SequenceToZone(tc:GetSequence())
end
