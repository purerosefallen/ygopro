--高速决斗技能-痛苦进化
Duel.LoadScript("speed_duel_common.lua")
function c100730100.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730100.skill,c100730100.con,aux.Stringid(100730100,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730100.Isyubel(c)
	return c:IsOriginalCodeRule(78371393,4779091) and c:IsFaceup()
end

function c100730100.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730100.Isyubel,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetMZoneCount(tp)>-1
end
function c100730100.SequenceToZone(seq)
	return 1 << seq
end
function c100730100.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.SelectMatchingCard(tp,c100730100.Isyubel,tp,LOCATION_MZONE,0,1,1,nil)
	if not g then return end
	local tc=g:GetFirst()
	local pos=tc:GetPosition()
	local seq=tc:GetSequence()
	if tc:IsOriginalCodeRule(78371393) then code=4779091 end
	if tc:IsOriginalCodeRule(4779091) then code=31764700 end
	Duel.SendtoGrave(tc,REASON_RULE)
	local nc=Duel.CreateToken(tp,code)
	Duel.MoveToField(nc,tp,tp,LOCATION_MZONE,pos,true)
	Duel.MoveSequence(nc,seq)
end
function c100730100.DisableMonsterZone(e,tp)
	return 0x1f-aux.SequenceToZone(tc:GetSequence())
end
