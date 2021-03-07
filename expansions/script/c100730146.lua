--高速决斗技能-究极进化药
Duel.LoadScript("speed_duel_common.lua")
function c100730146.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730146.skill,c100730146.con,aux.Stringid(100730146,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730146.Isdino(c)
	return c:IsRace(RACE_DINOSAUR) and c:IsType(TYPE_NORMAL)
end

function c100730146.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730146.Isdino,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.GetMZoneCount(tp)>-1
end
function c100730146.SequenceToZone(seq)
	return 1 << seq
end
function c100730146.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.SelectMatchingCard(tp,c100730146.Isdino,tp,LOCATION_GRAVE,0,1,1,nil)
	if not g then return end
	local tc=g:GetFirst()
	Duel.Remove(tc,POS_FACEUP,REASON_COST)
	local lp=Duel.GetLP(tp)
	Duel.SetLP(tp,lp-1500)
	local newc=Duel.CreateToken(tp,15894048)
	Duel.MoveToField(newc,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	e:Reset()
end
function c100730146.DisableMonsterZone(e,tp)
	return 0x1f-aux.SequenceToZone(tc:GetSequence())
end
