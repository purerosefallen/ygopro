--高速决斗技能-寄生虫感染
Duel.LoadScript("speed_duel_common.lua")
function c100730215.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730215.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730215.filter(c,g)
	if not c:IsRace(RACE_INSECT) then return false end
	local tc=g:GetFirst()
	while tc do
		if c:GetOriginalCode()==tc:GetOriginalCode() then
			return false
		end
		tc=g:GetNext()
	end
	g:AddCard(c)
	return true
end
function c100730215.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Group.CreateGroup()
	if not Duel.IsExistingMatchingCard(c100730215.filter,tp,LOCATION_DECK+LOCATION_HAND,0,4,nil,g) then Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730215,0)) e:Reset() return end
	local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND,0,1,2,nil,22493811)
	if g1:GetCount()==0 then e:Reset() return end
	Duel.Hint(HINT_CARD,1-tp,100730215)
	Duel.SSet(tp,g1)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)-Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	while ct>0 do
		local c=Duel.CreateToken(tp,27911549)
		Duel.DisableShuffleCheck()
		Duel.SendtoDeck(c,1-tp,0,REASON_RULE)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_DRAW)
		e1:SetOperation(c100730215.spop)
		e1:SetReset(RESET_EVENT+0x1de0000)
		c:RegisterEffect(e1)
		Card.ReverseInDeck(c)
		ct=ct-1
	end
	Duel.ShuffleDeck(1-tp)
	e:Reset()
end
function c100730215.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,tp,100730215)
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	Duel.Damage(tp,1000,REASON_EFFECT)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_RACE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetValue(RACE_INSECT)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
end