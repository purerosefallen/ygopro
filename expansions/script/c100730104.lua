--高速决斗技能-攻击力：8800P
Duel.LoadScript("speed_duel_common.lua")
function c100730104.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730104.skill,c100730104.con,aux.Stringid(100730104,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730104.Is8800(c)
	return c:IsLevel(4) and c:IsFaceup() and c:IsAttack(c:GetDefense())
end

function c100730104.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730104.Is8800,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetMZoneCount(tp)>-1
end
function c100730104.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730104)
	local g=Duel.GetMatchingGroup(c100730104.Is8800,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 then return end
	local e0=Effect.CreateEffect(e:GetHandler())
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e0:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e0:SetTargetRange(0,1)
	e0:SetValue(1)
	e0:SetReset(RESET_PHASE+PHASE_END)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(8800)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
	e:Reset()
end