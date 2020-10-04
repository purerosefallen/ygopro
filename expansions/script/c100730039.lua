--高速决斗技能-连锁反应
Duel.LoadScript("speed_duel_common.lua")
function c100730039.initial_effect(c)
	if not c100730039.chain then c100730039.chain={} end
	aux.SpeedDuelBeforeDraw(c,c100730039.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730039.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	--damage
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCondition(c100730039.damcon)
	e1:SetOperation(c100730039.regop)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_CHAIN_END)
	e2:SetOperation(c100730039.damop)
	Duel.RegisterEffect(e2,tp)
end

function c100730039.regop(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp and not c100730039.chain[re] and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_TRAP) then
		c100730039.chain[re]=true
		Duel.Hint(HINT_CARD,0,100730039)
		local lp=Duel.GetLP(1-tp)-200
		if lp<0 then lp=0 end
		Duel.SetLP(1-tp,lp)
	end
end
function c100730039.damcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_TRAP)
end
function c100730039.damop(e,tp,eg,ep,ev,re,r,rp)
	c100730039.chain={}
end
