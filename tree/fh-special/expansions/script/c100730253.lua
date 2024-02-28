--高速决斗技能-虚无的波动
Duel.LoadScript("speed_duel_common.lua")
function c100730253.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(63665606,c)
	aux.SpeedDuelMoveCardToFieldCommon(80921533,c)
	aux.SpeedDuelBeforeDraw(c,c100730253.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730253.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	--atk up
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c100730253.atcon)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100730253.tgfilter)
	e1:SetValue(400)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	Duel.RegisterEffect(e2,tp)
	e:Reset()
end
function c100730253.atcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_HAND,0)==0
end
function c100730253.tgfilter(e,c)
	return c:IsSetCard(0xb)
end