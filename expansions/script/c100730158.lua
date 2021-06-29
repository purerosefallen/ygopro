--高速决斗技能-火山之力
Duel.LoadScript("speed_duel_common.lua")
function c100730158.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730158.skill,c100730158.con,aux.Stringid(100730158,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730158.Isvol(c)
	return (c:IsOriginalCodeRule(21420702) and c:IsFaceup())
end

function c100730158.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730158.Isvol,tp,LOCATION_SZONE,0,1,nil)
		and Duel.GetMZoneCount(tp)>0
		and Duel.IsPlayerCanSpecialSummon(tp)
end
function c100730158.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.SelectMatchingCard(tp,c100730158.Isyvol,tp,LOCATION_SZONE,0,1,1,nil)
	if not g then return end
	local tc=g:GetFirst()
	Duel.SendtoGrave(tc,REASON_RULE)
	local nc=Duel.CreateToken(tp,32543380)
	Duel.SpecialSummon(nc,0,tp,tp,true,true,POS_FACEUP)
end
