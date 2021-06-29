--高速决斗技能-生命充能
Duel.LoadScript("speed_duel_common.lua")
function c100730110.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730110.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730110.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetCode(EVENT_TURN_END)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetCountLimit(1)
	e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,5)
	e1:SetOperation(c100730110.recop)
	e1:SetValue(c100730110.abdcon)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730110.recop(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp then return end
	local count= Duel.GetTurnCount()
	Duel.Hint(HINT_CARD,1-tp,100730110)
	Duel.Recover(tp,count*200,REASON_RULE)
	local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,0,1,nil,9032529)
	if g2:GetCount()==0 then return end
	Duel.SendtoHand(g2,tp,REASON_RULE)
end

function c100730110.abdcon(e)
	return Duel.GetTurnPlayer()==e:GetHandlerPlayer()
end