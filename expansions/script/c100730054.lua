--高速决斗技能-重新开始
Duel.LoadScript("speed_duel_common.lua")
function c100730054.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730054.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730054.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	e:Reset()
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	local ct=g:GetCount()
	if ct==0 then return end
	if not Duel.SelectYesNo(tp,aux.Stringid(100730054,0)) then return end
	aux.SpeedDuelSendToDeckWithExile(tp,g)
	local g2=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	g2=g2:RandomSelect(ct)
	aux.SpeedDuelSendToHandWithExile(tp,g2)
	
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_SKIP_DP)
	e1:SetTargetRange(1,0)
	if Duel.GetTurnPlayer()==tp then
		e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN,2)
	else
		e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN)
	end
	Duel.RegisterEffect(e1,tp)
end