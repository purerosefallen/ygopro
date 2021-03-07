--高速决斗技能-普拉那的心智
Duel.LoadScript("speed_duel_common.lua")
function c100730107.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730107.skill,c100730107.con,aux.Stringid(100730107,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730107.filter(c)
	return c:IsLocation(LOCATION_REMOVED)
end

function c100730107.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730107.filter,tp,0,LOCATION_REMOVED,1,nil)
end
function c100730107.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g1=Duel.GetMatchingGroup(c100730107.filter,tp,0,LOCATION_REMOVED,nil)
	Duel.Exile(g1,REASON_RULE)
end