--高速决斗技能恐龙基因
Duel.LoadScript("speed_duel_common.lua")
function c100730128.initial_effect(c)
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCountLimit(1)
	e1:SetOperation(c100730128.skill)
	Duel.RegisterEffect(e1,tp)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730128.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=Duel.GetTurnPlayer()
	g=e:GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730128)
	local lp=Duel.GetLP(g)
	Duel.SetLP(g,lp+350)
end