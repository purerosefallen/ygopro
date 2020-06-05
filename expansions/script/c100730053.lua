--高速决斗技能-新生宇宙
Duel.LoadScript("speed_duel_common.lua")
function c100730053.initial_effect(c)
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetOperation(c100730053.skill)
	Duel.RegisterEffect(e1,0)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730053.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=Duel.GetTurnPlayer()
	Duel.Hint(HINT_CARD,tp,100730053)
	Duel.Hint(HINT_CARD,1-tp,100730053)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)*100
	ct=Duel.GetLP(tp)-ct
	if ct<0 then ct=0 end
	Duel.SetLP(tp,ct)
end