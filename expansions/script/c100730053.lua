--高速决斗技能黑暗决斗
Duel.LoadScript("speed_duel_common.lua")
function c100730053.initial_effect(c)
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TURN_END)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCountLimit(1)
	e1:SetOperation(c100730053.skill)
	Duel.RegisterEffect(e1,0)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730053.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=Duel.GetTurnPlayer()
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)*200
	Duel.Hint(HINT_CARD,1-tp,100730053)
	Duel.Damage(tp,ct,REASON_RULE)
end