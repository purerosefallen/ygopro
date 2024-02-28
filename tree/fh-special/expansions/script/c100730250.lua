--高速决斗技能-新宇防御
Duel.LoadScript("speed_duel_common.lua")
function c100730250.initial_effect(c)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c100730250.imtg)
	e2:SetValue(1)
	Duel.RegisterEffect(e2,c)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730250.imtg(e,c)
	return c:IsCode(89943723)
end