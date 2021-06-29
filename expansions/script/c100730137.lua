--高速决斗技能-№系规则
Duel.LoadScript("speed_duel_common.lua")
function c100730137.initial_effect(c)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x48))
	e2:SetValue(c100730137.indval)
	Duel.RegisterEffect(e2,c)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730137.indval(e,c)
	return not c:IsSetCard(0x48)
end