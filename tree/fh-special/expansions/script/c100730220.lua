--高速决斗技能-致命五连击
Duel.LoadScript("speed_duel_common.lua")
function c100730220.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730220.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730220.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLED)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c100730220.btcon)
	e1:SetOperation(c100730220.op)
	e1:SetCountLimit(1)
	e1:SetValue(c100730220.abdcon)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end

function c100730220.btcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if a:IsControler(1-tp) then a,d=d,a end
	if a then
		a:RegisterFlagEffect(100730220,RESET_EVENT+0x3fe0000+RESET_PHASE+PHASE_END,0,1)
		return a:GetFlagEffect(100730220)==5
	else return false end
end

function c100730220.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,100730220)
	Duel.Win(tp,WIN_REASON_LAST_TURN)
end
function c100730220.abdcon(e)
	return Duel.GetTurnPlayer()==e:GetHandlerPlayer()
end