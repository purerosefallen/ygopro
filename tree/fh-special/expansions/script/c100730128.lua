--高速决斗技能-生命充能
Duel.LoadScript("speed_duel_common.lua")
function c100730128.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730128.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730128.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetCode(EVENT_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetCountLimit(1)
	e1:SetTarget(c100730128.rectg)
	e1:SetOperation(c100730128.recop)
	e1:SetValue(c100730128.abdcon)
	Duel.RegisterEffect(e1,tp)
end
function c100730128.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	tp=Duel.GetTurnPlayer()
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(200)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,200)
end

function c100730128.recop(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp then return end
	Duel.Hint(HINT_CARD,1-tp,100730128)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_RULE)
end

function c100730128.abdcon(e)
	return Duel.GetTurnPlayer()==e:GetHandlerPlayer()
end