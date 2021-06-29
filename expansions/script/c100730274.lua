--高速决斗技能-来自深渊的威胁
Duel.LoadScript("speed_duel_common.lua")
function c100730274.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730274.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730274.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local c=e:GetHandler()
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c100730274.waterfilter)
	e2:SetCondition(c100730274.econ)
	e2:SetValue(c100730274.val)
	Duel.RegisterEffect(e2,tp)
	e:Reset()
end
function c100730274.waterfilter(e,c)
	return c:IsAttribute(ATTRIBUTE_WATER)
end
function c100730274.econ(e)
	return Duel.IsEnvironment(22702055)
end