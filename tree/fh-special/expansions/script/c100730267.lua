--高速决斗技能-恐龙粉碎
Duel.LoadScript("speed_duel_common.lua")
function c100730267.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730267.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730267.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730267)
	local c=e:GetHandler()
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_PIERCE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c100730267.pietg)
	Duel.RegisterEffect(e2,tp)
	e:Reset()
end
function c100730267.pietg(e,c)
	return c:IsRace(RACE_DINOSAUR) and c:IsLevelAbove(6)
end