--高速决斗技能-拜拜了！
Duel.LoadScript("speed_duel_common.lua")
function c100730246.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730246.skill,c100730246.con,aux.Stringid(100730246,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730246.filter(c,tp)
	return c:GetOwner()==tp
end

function c100730246.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730246.filter,tp,LOCATION_MZONE,0,1,nil,tp)
end

function c100730246.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730246)
	local g=Duel.SelectMatchingCard(tp,c100730246.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		local c=Duel.CreateToken(tp,93108433)
		Duel.SendtoHand(c,nil,REASON_RULE)
	end
	e:Reset()
end