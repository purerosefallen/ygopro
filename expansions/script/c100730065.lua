--高速决斗技能-拜拜了！
Duel.LoadScript("speed_duel_common.lua")
function c100730065.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730065.skill,c100730065.con,aux.Stringid(100730065,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730065.filter(c,tp)
	return c:GetOwner()==tp
end

function c100730065.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730065.filter,tp,LOCATION_MZONE,0,1,nil,tp)
end

function c100730065.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730065)
	local g=Duel.SelectMatchingCard(tp,c100730065.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		local c=Duel.CreateToken(tp,93108433)
		Duel.SendtoHand(c,nil,REASON_RULE)
	end
	e:Reset()
end