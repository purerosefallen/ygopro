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
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.GetMZoneCount(tp)>-1
end
function c100730146.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.SelectMatchingCard(tp,c100730146.Isdino,tp,LOCATION_GRAVE,0,1,1,nil)
	if not g then return end
	local tc=g:GetFirst()
	Duel.Remove(tc,POS_FACEUP,REASON_COST)
	Duel.PayLPCost(tp,1500)
	local newc=Duel.CreateToken(tp,15894048)
	Duel.SpecialSummon(newc,0,tp,tp,true,true,POS_FACEUP)
	e:Reset()
end
