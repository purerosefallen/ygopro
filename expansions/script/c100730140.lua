--高速决斗技能-是我更快！
Duel.LoadScript("speed_duel_common.lua")
function c100730140.initial_effect(c)
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetOperation(c100730140.skill)
	Duel.RegisterEffect(e1,tp)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730140.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=Duel.GetTurnPlayer()
	Duel.Hint(HINT_CARD,1-tp,100730140)
	local lp=Duel.GetLP(tp)
	Duel.SetLP(tp,lp+2000)
	local lp2=Duel.GetLP(1-tp)
	Duel.SetLP(1-tp,lp2-2000)
	e:Reset()
end